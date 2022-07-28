# frozen_string_literal: true

class AddColumnToJobApplications < ActiveRecord::Migration[6.0]
  def change
    add_column :job_applications, :status, :integer, default: 0
    add_index  :job_applications, :status
  end
end
