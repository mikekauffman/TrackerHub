class TrackerSearchController < ApplicationController

  def index
    @json_data = TrackerSearch.fetch_projects
  end

end