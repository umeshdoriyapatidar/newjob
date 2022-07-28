# frozen_string_literal: true

class JobApplication < ApplicationRecord
  belongs_to :applied_users, class_name: 'User', foreign_key: 'user_id'
  belongs_to :applied_jobs, class_name: 'Job', foreign_key: 'job_id'

  enum status: { hold: 0, accepted: 1, rejected: 2 }
  paginates_per 5
end
