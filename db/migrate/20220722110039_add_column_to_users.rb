# frozen_string_literal: true

class AddColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :apply_otp, :integer
  end
end
