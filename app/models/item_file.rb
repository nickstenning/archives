require 'pathname'

class ItemFile < ActiveRecord::Base

  belongs_to :item
  
  validates_presence_of :url, :message => "can't be blank"

  def self.find_unprocessed
    incoming = Pathname.new(AppConfig.incoming_path).expand_path

    unless incoming.directory?
      raise ConfigurationError, "Archives incoming_path '#{incoming}' does not exist or is not a directory."
    end

    return Pathname.glob(incoming + '*.tif')
  end

end
