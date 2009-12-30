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
        doc_id = f.basename.to_s[0...-f.extname.length] # "foo/bar/baz.tif" -> "baz"
        create_folder_for(doc_id)
        f.rename(original_path(doc_id)) # 'original' as in the original imported file.
        create_attachment_for(doc_id)
        create_pdf_for(doc_id)
      end
    end
    
    protected
    
    def folder_path(doc_id)
      @archives_path + doc_id
    end
    
    def original_path(doc_id)
      folder_path(doc_id) + "#{doc_id}.tif" # we standardise the original's extension.
    end
    
    def pdf_path(doc_id)
      folder_path(doc_id) + "#{doc_id}.pdf"
    end
    
    def create_folder_for(doc_id)
      # TODO: raise more enlightening error types
      if folder_path(doc_id).exist?
        raise Exception, "Can't import, an image with doc_id '#{doc_id}' already exists in '#{@archives_path}'"
      else
        folder_path(doc_id).mkdir
      end
    end
    
    def create_attachment_for(doc_id)
      Attachment.create(:doc_id => doc_id)
    end
    
    def create_pdf_for(doc_id)
      unless Pathname(AppConfig.tiff2pdf).executable?
        raise Exception, "tiff2pdf executable appears invalid: check '#{AppConfig.tiff2pdf}', as specified in config/archives.yml"
      end
      system("#{AppConfig.tiff2pdf} -o '#{pdf_path(doc_id)}' '#{original_path(doc_id)}'")
    end
    
    def check_paths!
      ['incoming', 'archives'].each do |name|
        path = instance_variable_get("@#{name}_path")
        raise Errno::ENOENT, "#{name.capitalize} path '#{path}' does not exist" unless path.exist?
      end
    end
    
  end
end