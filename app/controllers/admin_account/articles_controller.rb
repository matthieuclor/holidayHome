# frozen_string_literal: true

module AdminAccount
  class ArticlesController < AdminAccount::ApplicationController
    respond_to :js, :html
    before_action :set_article, only: %i(show edit update destroy)

    def index
      @query = Article.ransack(article_ransack_params)
      @pagy, @articles = pagy(@query.result.with_rich_text_body_and_embeds)
    end

    def show
    end

    def new
      @article = Article.new
    end

    def edit
    end

    def create
      @article = Article.new(article_params)

      if @article.save
        flash[:success] = t('.success')
        render js: 'location.reload()'
      else
        flash[:error] = t('.error')
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @article.update(article_params)
        flash[:success] = t('.success')
        render js: 'location.reload()'
      else
        flash[:error] = t('.error')
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @article.destroy
        flash[:success] = t('.success')
        redirect_to admin_account_articles_path
      else
        flash[:error] = t('.error')
        render :show
      end
    end

    private

    def set_article
      @article = Article.with_rich_text_body_and_embeds.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :body)
    end

    def article_ransack_params
      @article_ransack_params ||= params[:q]&.permit(:title_cont, :status_eq)
    end
  end
end
