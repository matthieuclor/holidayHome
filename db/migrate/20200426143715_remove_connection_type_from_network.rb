# frozen_string_literal: true

class RemoveConnectionTypeFromNetwork < ActiveRecord::Migration[6.0]
  def change
    remove_column :networks, :network_name
    remove_column :networks, :connection_type
  end
end
