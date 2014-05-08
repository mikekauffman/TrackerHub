class Project

  def self.fetch_projects
    conn = Faraday.new
    projects_response = conn.get 'https://www.pivotaltracker.com/services/v5/projects' do |request|
      request.headers['Content-Type'] = 'application/json'
      request.headers['X-TrackerToken'] = ENV['TRACKER_ID']
    end
    JSON.parse (projects_response.body)
  end

  def self.fetch_stories(project_id)
    conn = Faraday.new
    stories_response = conn.get "https://www.pivotaltracker.com/services/v5/projects/#{project_id}/stories" do |request|
      request.headers['Content-Type'] = 'application/json'
      request.headers['X-TrackerToken'] = ENV['TRACKER_ID']
    end
    JSON.parse (stories_response.body)
  end

  def self.fetch_comments(project_id)
    conn = Faraday.new
    comments_response = conn.get "https://www.pivotaltracker.com/services/v5/projects/#{project_id}/stories?fields=comments" do |request|
      request.headers['Content-Type'] = 'application/json'
      request.headers['X-TrackerToken'] = ENV['TRACKER_ID']
    end
    comments = []
    JSON.parse(comments_response.body).each do |story|
      story["comments"].each do |story_comments|
        comments << story_comments["text"]
      end
    end
    comments
  end

  def self.fetch_git_comments(project_id)
    Github.new(fetch_comments(project_id)).generate_api_urls.each do |url|
      @github_data = connection.get(url)
    end
    JSON.parse(@github_data.body).map {|comment| comment["body"]}
  end

  def self.connection
    Faraday.new(:url => "https://api.github.com") do |faraday|
      faraday.adapter(Faraday.default_adapter)
      faraday.basic_auth(ENV["GITHUB_USERNAME"], ENV["GITHUB_PASSWORD"])
    end
  end

end