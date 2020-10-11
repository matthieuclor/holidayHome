# frozen_string_literal: true

module Public
  class RgpdCookiesController < ApplicationController
    respond_to :js

    def create
      cookies[:hutoki_rgpd] = { value: "accepted", expires: 13.month.from_now }
    end
  end
end
