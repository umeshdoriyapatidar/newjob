class AddColumnToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :address, :text
    add_column :users, :skills, :string
    add_column :users, :description, :text
  end
end
