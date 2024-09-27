set :output, "log/cron_log.log"

every 1.day, at: '12:00 am' do
  runner "DeleteExpiredOffersJob.perform_later"
end
