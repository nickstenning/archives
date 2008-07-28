desc "Setup environment for ADC archives project"
task :setup do
  puts "Copying config/database.yml.example to config/database.yml."
  puts "You can edit config/database.yml to customize your database settings."
  FileUtils.cp("config/database.yml.example", "config/database.yml")
end

