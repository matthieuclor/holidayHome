# frozen_string_literal: true

module ArticlesHelper
  def article_status_badge(article)
    content_tag(
      :span,
      Article.human_attribute_name("status.#{article.status}"),
      class: ["badge badge-#{article.online? ? 'success' :  'danger'}"]
    )
  end
end
