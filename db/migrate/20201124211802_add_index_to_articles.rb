# frozen_string_literal: true

class AddIndexToArticles < ActiveRecord::Migration[6.0]
  def change
    add_index :articles, :title, unique: true
    add_index :articles, :slug, unique: true
  end
end
