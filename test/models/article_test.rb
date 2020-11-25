# frozen_string_literal: true

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  setup do
    @article = articles(:first_article)
  end

  test 'valid article' do
    assert @article.valid?
  end

  test 'default article status must be offline' do
    assert @article.offline?
  end

  %i(title body).each do |attibute|
    test "invalid article without #{attibute}" do
      @article.send("#{attibute}=", nil)
      assert_not @article.valid?
      assert_not_nil @article.errors[attibute]
    end
  end

  test 'invalid article with duplicate title and slug' do
    article = build(:article, { title: @article.title })
    assert_not article.valid?
    assert_not_nil article.errors[:title]
    assert_not_nil article.errors[:slug]
  end

  test 'generate slug from title before validate article' do
    article = build(:article, { title:  'Ceci est un test !' })
    article.valid?
    assert_equal article.slug, 'ceci-est-un-test'
  end
end
