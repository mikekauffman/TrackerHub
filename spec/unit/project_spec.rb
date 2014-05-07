require 'spec_helper'

describe Project do
  before {
    @projects = Project.fetch_projects
    @project_id = @projects.first["id"]
  }
  it 'should return an array of projects' do
    expect(@projects.count).to eq 9
  end

  it 'should return an array of stories in a project' do
    stories = Project.fetch_stories(@project_id)
    expect(stories.count).to eq 7
  end

  it 'should return an array of comments for a project' do
    comments = Project.fetch_comments(@project_id)
    expect(comments.count).to eq 5
  end

end