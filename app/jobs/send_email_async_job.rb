class SendEmailAsyncJob < ApplicationJob
  queue_as :default

  def perform(user)
  	user = User.find(user)
    UserMailer.welcome_email(user).deliver_now
  end
end
