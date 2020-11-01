# frozen_string_literal: true

require 'test_helper'

module Public
  class ArticlesControllerTest < ActionDispatch::IntegrationTest
    test "should get online articles" do
      get articles_url
      articles = @controller.view_assigns["articles"]
      assert_instance_of Article, articles.first
      articles.each { |article| assert article.online? }
      assert_response :success
    end

    test "should get online article" do
      second_article = articles(:second_article)
      get article_url(slug: second_article.slug)

      article = @controller.view_assigns["article"]
      assert_instance_of Article, article
      assert article.online?
      assert_response :success
    end

    test "should not get offline article" do
      first_article = articles(:first_article)
      get article_url(slug: first_article.slug)

      assert_nil @controller.view_assigns["article"]
      assert_response :not_found
    end
  end
end
