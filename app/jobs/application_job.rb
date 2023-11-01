class ApplicationJob < ActiveJob::Base
  queue_as :mailers

  def perform(devise_mailer, method,user_id, *args)
    user = User.find(user_id)
    devise_maier.send(method,user,*args).deliver_now
  end
  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError
end
