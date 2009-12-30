namespace "adc" do

  desc "Run ADC image importer"
  task :import => :environment do
    importer = ADC::Importer.new(AppConfig.incoming_path, AppConfig.archives_path)
    importer.perform
  end

end