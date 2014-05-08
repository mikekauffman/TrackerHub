require 'spec_helper'

describe Project do
  before {
    VCR.use_cassette('projects') do
      @projects = Project.all
    end
    @project_id = @projects.first["id"]
  }
  it 'should return an array of projects' do
    expect(@projects.count).to eq 9
  end

  it 'should return an array of stories in a project' do
    VCR.use_cassette('stories') do
      stories = Project.new(@project_id).fetch_stories
      expect(stories.count).to eq 7
    end
  end

  it 'should return an array of comments for a project' do
    VCR.use_cassette('comments') do
      comments = Project.new(@project_id).fetch_comments
      expect(comments.count).to eq 7
    end
  end

  it 'should return an array of github comments for an integrated project' do
    VCR.use_cassette('github_comments') do
      git_comments = Project.new(@project_id).fetch_git_comments
      expect(git_comments.length).to eq 6
    end
  end

end