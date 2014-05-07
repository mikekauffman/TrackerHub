class TrackerSearchController < ApplicationController

  def index
    @json_data = TrackerSearch.fetch_projects
  end

  def show
    @project_data = TrackerSearch.fetch_stories(params[:id])
  end
end