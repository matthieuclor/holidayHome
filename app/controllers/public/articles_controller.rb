# frozen_string_literal: true

module Public
  class ArticlesController < ApplicationController
    def index
      @query = Article.online.ransack(article_ransack_params)
      @articles = @query.result
    end

    def show
      @article = Article.online.find_by(slug: params[:slug])
      head :not_found unless @article
    end

    private

    def article_ransack_params
      @article_ransack_params ||= params[:q]&.permit(:title_cont)
    end
  end
end
