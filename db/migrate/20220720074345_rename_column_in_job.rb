# frozen_string_literal: true

class RenameColumnInJob < ActiveRecord::Migration[6.0]
  def change
    rename_column :jobs, :users_id, :user_id
  end
end
