# frozen_string_literal: true

module SkipBullet
  extend ActiveSupport::Concern

  included do
    def skip_bullet
      Rails.env.test? && Bullet.enable = false
      yield
    ensure
      Rails.env.test? && Bullet.enable = true
    end
  end
end
