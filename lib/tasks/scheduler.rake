require "#{Rails.root}/app/helpers/application_helper"
desc 'This task is called by the Heroku scheduler add-on'
task remove_instances: :environment do
  puts 'Removing all instances from the @@all hash'
  include QueriesHelper
  QueryResult.remove_all
  puts 'done.'
end

# task :send_reminders => :environment do
#   User.send_reminders
# end
