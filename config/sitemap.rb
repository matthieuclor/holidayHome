# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://www.hutoki.com"
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
SitemapGenerator::Sitemap.create do
  add articles_path, priority: 0.7, changefreq: 'daily'

  Article.online.each do |article|
    add article_path(article), lastmod: article.updated_at, priority: 0.7
  end

  add question_and_answers_path,
      lastmod: QuestionAndAnswer.online.maximum(:updated_at),
      priority: 0.2

  add team_members_path,
      lastmod: TeamMember.online.maximum(:updated_at),
      priority: 0.2

  add root_path, changefreq: 'monthly', priority: 0.2
  add about_path, changefreq: 'monthly', priority: 0.2
  add pricing_path, changefreq: 'monthly', priority: 0.2
  add privacy_policy_path, changefreq: 'monthly', priority: 0.2
  add company_details_path, changefreq: 'monthly', priority: 0.2
  add cgu_path, changefreq: 'monthly', priority: 0.2
  add sitemaps_path, changefreq: 'monthly', priority: 0.2
end
