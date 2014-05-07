class ProjectsController < ApplicationController

  def index
    @json_data = Project.fetch_projects
  end

  def show
    @project_data = Project.fetch_stories(params[:id])
    @story_comments = Project.fetch_comments(params[:id])
  end
end