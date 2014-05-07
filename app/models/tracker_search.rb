class TrackerSearch
  def self.fetch_projects
    conn = Faraday.new
    projects_response = conn.get 'https://www.pivotaltracker.com/services/v5/projects' do |request|
      request.headers['Content-Type'] = 'application/json'
      request.headers['X-TrackerToken'] = ENV['TRACKER_ID']
    end
    JSON.parse (projects_response.body)
  end
end