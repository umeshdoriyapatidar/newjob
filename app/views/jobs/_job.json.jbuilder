# frozen_string_literal: true

json.extract! job, :id, :job_title, :salary, :experience, :skillset, :description, :created_at, :updated_at
json.url job_url(job, format: :json)
