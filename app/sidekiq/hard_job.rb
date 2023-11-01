class HardJob
  include Sidekiq::Job

  def perform(name, count)
    # do something
  end
end