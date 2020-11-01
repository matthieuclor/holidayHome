# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://www.hutoki.com"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host

  add articles_path, priority: 0.7, changefreq: 'daily'

  Article.online.each do |article|
    add article_path(article), lastmod: article.updated_at, priority: 0.7
  end

  add question_and_answers_path,
      lastmod: QuestionAndAnswer.online.maximum(:updated_at),
      priority: 0.2

  add about_path, changefreq: 'monthly', priority: 0.2
  add pricing_path, changefreq: 'monthly', priority: 0.2
  add teams_path, changefreq: 'monthly', priority: 0.2
end
