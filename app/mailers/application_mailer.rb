# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'naukriwalla@mail.com'
  layout 'mailer'
end
