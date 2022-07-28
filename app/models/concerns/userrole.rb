# frozen_string_literal: true

Module Userrole
  include ActiveSupport::Concern
  included do 
    def employer?
      role == 'employer'
    end

    def applicant?
      role == 'applicant'
    end
  end
end