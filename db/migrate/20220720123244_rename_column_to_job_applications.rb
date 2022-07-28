# frozen_string_literal: true

class RenameColumnToJobApplications < ActiveRecord::Migration[6.0]
  def change
    rename_column :job_applications, :users_id, :user_id
    rename_column :job_applications, :jobs_id, :job_id
  end
end
