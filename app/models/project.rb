class Project

  def initialize(project_id)
    @project_id = project_id
  end

  def self.all
    JSON.parse (pivotal_connection.get.body)
  end

  def fetch_stories
    JSON.parse ((Project.pivotal_connection.get ("#{@project_id}/stories")).body)
  end

  def fetch_comments
    comments = []
    JSON.parse((Project.pivotal_connection.get("#{@project_id}/stories?fields=comments")).body).each do |story|
      story["comments"].each do |story_comments|
        comments << story_comments["text"]
      end
    end
    comments
  end

  def fetch_git_comments
    if Github.new(fetch_comments).generate_api_urls
    @request_comments_array = Github.new(fetch_comments).generate_api_urls.map do |url|
      JSON.parse(Project.github_connection.get(url).body)
    end
    @all_comments = []
    @request_comments_array.flatten.each do |comment|
        @all_comments << comment
      end
    @all_comments
    else
      [{"body" => "There are no github comments on this project"}]
    end
  end

  def self.post_git_comment(owner, repo, sha, comment)
    body = {
      body: comment.to_s
    }
    JSON.parse(github_connection.post("repos/#{owner}/#{repo}/commits/#{sha}/comments", body.to_json).body)
  end

  def self.pivotal_connection
    Faraday.new(:url => "https://www.pivotaltracker.com/services/v5/projects") do |faraday|
      faraday.adapter(Faraday.default_adapter)
      faraday.headers['Content-Type'] = 'application/json'
      faraday.headers['X-TrackerToken'] = ENV['TRACKER_ID']
    end
  end

  def self.github_connection
    Faraday.new(:url => "https://api.github.com") do |faraday|
      faraday.adapter(Faraday.default_adapter)
      faraday.basic_auth(ENV["GITHUB_USERNAME"], ENV["GITHUB_PASSWORD"])
    end
  end

end