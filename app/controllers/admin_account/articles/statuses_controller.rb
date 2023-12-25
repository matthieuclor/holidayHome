# frozen_string_literal: true

module AdminAccount
  module Articles
    class StatusesController < AdminAccount::ApplicationController
      respond_to :js

      def update
        @article = Article.find(params[:article_id])

        if @article.update(article_params)
          flash[:success] = t('.success')
          render js: 'location.reload()'
        else
          flash[:error] = t('.error')
          render :update, status: :unprocessable_entity
        end
      end

      private

      def article_params
        params.require(:article).permit(:status)
      end
    end
  end
end
