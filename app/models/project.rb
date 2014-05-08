class Project

  def initialize(project_id)
    @project_id = project_id
  end

  def self.all
    projects_response = pivotal_connection.get
    JSON.parse (projects_response.body)
  end

  def fetch_stories
    stories_response = Project.pivotal_connection.get ("#{@project_id}/stories")
    JSON.parse (stories_response.body)
  end

  def fetch_comments
    comments_response = Project.pivotal_connection.get ("#{@project_id}/stories?fields=comments")
    comments = []
    JSON.parse(comments_response.body).each do |story|
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