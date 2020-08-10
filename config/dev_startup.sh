echo 'install gems'
bundle exec || bundle install

echo 'create db'
bundle exec rake db:create

echo 'prepare db'
bundle exec rake db:test:prepare

echo 'execute rails db:migrate for dev and test enviroments'
bundle exec rake db:schema:load
RAILS_ENV=test bundle exec rake db:schema:load

echo 'load seed data'
bundle exec rake db:seed

echo 'Start rails'
exec bundle exec rails server