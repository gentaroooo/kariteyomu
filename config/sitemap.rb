# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://www.kariteyomu.net/"

SitemapGenerator::Sitemap.create do
  add root_path, priority: 1.0, changefreq: 'daily'
  add posts_path, priority: 0.7, changefreq: 'daily'
  Post.find_each do |post|
    add post_path(post), lastmod: post.updated_at
  end
end
