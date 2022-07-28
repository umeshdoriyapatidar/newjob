# frozen_string_literal: true

module JobApplicationsHelper
  def is_applied(current_user, job_id)
    if current_user.job_applications.find_by(job_id: job_id)
      true
    else
      false
    end
  end

  def application_status(user_id, jobs_id)
    job_application = JobApplication.find_by(job_id: jobs_id, user_id: user_id)
    job_application.status
  end

  def application_time(user_id, jobs_id)
    job_application = JobApplication.find_by(job_id: jobs_id, user_id: user_id)
    job_application.created_at
  end

  def valid_employer(user, job)
    if user.has_role? :employer
      user.jobs.include?(job)
    else
      false
    end
  end
end
