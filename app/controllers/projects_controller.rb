class ProjectsController < ApplicationController

  def index
    @json_data = Project.all
  end

  def show
    @project_data = Project.new(params[:id]).fetch_stories
    @story_comments = Project.new(params[:id]).fetch_comments
    @github_comments =  Project.new(params[:id]).fetch_git_comments
  end

  def add_comment
  end

  def create
    Project.post_git_comment(params[:owner], params[:repo_name], params[:sha_id], params[:comment_text])
    redirect_to "/projects/#{params[:id]}"
  end
end