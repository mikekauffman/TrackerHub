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

end