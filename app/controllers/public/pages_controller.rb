# frozen_string_literal: true

module Public
  class PagesController < ApplicationController
    def main
    end

    def about
    end

    def pricing
    end

    def cgu
    end

    def privacy_policy
    end

    def company_details
    end

    def sitemaps
      @articles = Article.online.pluck(:slug)
    end
  end
end
