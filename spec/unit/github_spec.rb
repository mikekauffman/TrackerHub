require 'spec_helper'

describe Github do
  before {
    VCR.use_cassette('github_comments') do
      @tracker_comments = Project.fetch_comments(1075366)
      @github = Github.new(@tracker_comments)
    end
  }
  it 'should get only github comments' do
    github_comments = @github.github_comments
    expect(github_comments.all? { |url| url.include?('https://github.com') }).to eq true
  end

  it 'should format github comment urls to extract key information' do
    split_comments = @github.split_github_urls
    expect(split_comments.first).to match_array ["https:", "", "github.com", "mikekauffman", "TrackerHub", "commit", "31168775b60990b963a6bf2859670e60185f8176"]
  end

  it 'should return the url from a github commit integrated with tracker' do
    formatted_urls = @github.generate_api_urls
    expect(formatted_urls.first).to eq '/repos/mikekauffman/TrackerHub/commits/31168775b60990b963a6bf2859670e60185f8176/comments'
  end

end