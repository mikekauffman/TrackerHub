class ProjectsController < ApplicationController

  def index
    @json_data = Project.all
  end

  def show
    @project_data = Project.new(params[:id]).fetch_stories
    @story_comments = Project.new(params[:id]).fetch_comments
    @github_comments =  Project.new(params[:id]).fetch_git_comments
  end
end