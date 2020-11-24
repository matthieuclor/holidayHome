# frozen_string_literal: true

module AdminAccount
  module Articles
    class StatusesController < AdminAccount::ApplicationController
      respond_to :js

      def update
        @article = Article.find(params[:article_id])

        if @article.update(article_params)
          flash[:success] = "L'article a bien été mis à jour"
          render js: 'location.reload()'
        else
          flash[:error] = "Un problem est survenu lors de la mise à jour de l'article"
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
