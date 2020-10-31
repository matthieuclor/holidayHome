# frozen_string_literal: true

module Public
  class ArticlesController < ApplicationController
    def index
      @articles = Article.online
    end

    def show
      @article = Article.online.find_by(slug: params[:slug])
    end
  end
end
