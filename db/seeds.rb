env = Rails.env
seed_file = "#{Rails.root}/db/seeds/#{env}.rb"
if File.exists?(seed_file)
  puts "*** Loading #{env} seed data"
  require seed_file
else
  seed_file = "#{Rails.root}/db/seeds/default.rb"
  puts '*** Loading default seed data'
  require seed_file
end