class Github

  def initialize(tracker_comments)
    @tracker_comments = tracker_comments
  end

  def self.commit_comment_parse(comment)
    split_comment = comment.split(" ")
    split_url = []
    split_comment.flatten.each do |comment|
      if comment.include?('https://')
        split_url << comment.split("/")
      end
    end
    split_url[0]
  end

  def generate_api_urls
    if split_github_urls
      split_github_urls.map do |url_array|
        "/repos/#{url_array[3]}/#{url_array[4]}/commits/#{url_array[6]}/comments"
      end
    end
  end

  def github_comments
    @tracker_comments.select do |comment|
      comment.include?('https://github.com')
    end
  end

  def split_github_urls
    comments_split = []
    github_comments.each do |comment|
      comments_split << comment.split("\n")
      @split_urls = comments_split.map do |split_comment|
        split_comment[1].split('/')
      end
    end
    @split_urls
  end

end