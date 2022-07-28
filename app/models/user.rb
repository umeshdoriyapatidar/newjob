# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  attr_accessor :user_roles

  has_many :jobs, dependent: :destroy
  has_many :job_applications
  has_many :applied_jobs, through: :job_applications, dependent: :destroy

  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable  ,:confirmable

  validates :user_roles, inclusion: { in: %w[employer applicant], message: '%<value>s is not a valid role' }, if: lambda {
                                                                                                                    user_roles.present?
} 
  validates :name, presence:true

  before_create :assign_default_role
  def assign_default_role
    # self.add_roles(:applicant)
    if user_roles.blank?
      add_role(:applicant)
    else
      add_role(user_roles)
    end
  end

  def aply(job)
    applied_jobs << job
  end
end
