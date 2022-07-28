# frozen_string_literal: true

class Job < ApplicationRecord
  rolify
  belongs_to :user
  paginates_per 5
  has_many :job_applications ,dependent: :destroy
  has_many :applied_users, through: :job_applications

  validates :job_title, :experience, presence: true
end
