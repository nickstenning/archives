desc "Setup environment for ADC archives project"
task :setup do
  unless File.exist? "config/database.yml"
    puts "Copying config/database.yml.example to config/database.yml."
    FileUtils.cp("config/database.yml.example", "config/database.yml")
  end
end

