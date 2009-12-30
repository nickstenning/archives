require 'pathname'

module ADC
  
  class Importer
    
    attr_accessor :incoming_path, :archives_path
    
    def initialize(incoming_path, archives_path)
      @incoming_path = Pathname(incoming_path)
      @archives_path = Pathname(archives_path)
      check_paths!
    end
    
    def incoming_path
      @incoming_path.to_s
    end
    
    def archives_path
      @archives_path.to_s
    end
    
    def perform
      # This glob pattern should case-insensitively match *.tif or *.tiff files.
      Pathname.glob(@incoming_path + '*.[Tt][Ii][Ff]{[Ff],}').each do |f|
        new_path = @archives_path + f.basename
        f.rename(new_path)
        create_attachment_for(new_path)
      end
    end
    
    def create_attachment_for(path)
      Attachment.create(:url => path.relative_path_from(@archives_path).to_s)
    end
    
    def check_paths!
      ['incoming', 'archives'].each do |name|
        path = instance_variable_get("@#{name}_path")
        raise Errno::ENOENT, "#{name.capitalize} path '#{path}' does not exist!" unless path.exist?
      end
    end
    
  end
end