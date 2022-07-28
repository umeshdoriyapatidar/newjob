# frozen_string_literal: true

class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.references :users, foreign_key: true, index: true
      t.string :job_title, null: false
      t.float :salary
      t.string :experience, null: false
      t.string :skillset
      t.text :description

      t.timestamps
    end
  end
end
