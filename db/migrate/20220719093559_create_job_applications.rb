# frozen_string_literal: true

class CreateJobApplications < ActiveRecord::Migration[6.0]
  def change
    create_table :job_applications do |t|
      t.references :jobs, foregin_key: true, index: true
      t.references :users, foregin_key: true, index: true

      t.timestamps
    end
  end
end
