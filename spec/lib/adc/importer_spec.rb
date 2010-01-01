require File.dirname(__FILE__) + '/../../spec_helper'
require 'tmpdir'
require 'pathname'
require 'base64'

MINITIFF = 'SUkqAAoAAAAAABIAAAEDAAEAAAABAAAAAQEDAAEAAAABAAAAAgEDAAIAAAABAAEAAwEDAAEAAAAB' +
           'AAAABgEDAAEAAAABAAAACgEDAAEAAAABAAAADQECAAkAAADoAAAAEQEEAAEAAAAIAAAAEgEDAAEA' +
           'AAABAAAAFQEDAAEAAAACAAAAFgEDAAEAAAAAIAAAFwEEAAEAAAABAAAAGgEFAAEAAADyAAAAGwEF' +
           'AAEAAAD6AAAAHAEDAAEAAAABAAAAKAEDAAEAAAABAAAAMQECADoAAAACAQAAUgEDAAEAAAACAAAA' +
           'AAAAADF4MS50aWZmAAAAAABIAAAAAQAAAEgAAAABSW1hZ2VNYWdpY2sgNi40LjEgMDYvMTkvMDgg' +
           'UTE2IGh0dHA6Ly93d3cuaW1hZ2VtYWdpY2sub3JnAA=='

# TODO: Consider speed of PDF creation/TIFF writing. Is there any way we can 
#       mock this stuff out?

describe ADC::Importer do
  
  def create_tiff_file(pathname, name)
    file = (pathname + name)
    file.open('wb') do |f|
      # Write out a 1x1 TIFF file from base64 encoded string.
      f.write(Base64.decode64(MINITIFF))
    end
    return file
  end
  
  before do
    @tmpdir = Pathname(Dir.tmpdir + '/' + rand.to_s[2..8])
    @tmpdir.mkdir
    
    @incoming = @tmpdir + 'incoming'
    @archives = @tmpdir + 'archives'
    
    [@incoming, @archives].each(&:mkdir)
    ['a', 'b', 'c'].each do |name|
      file = create_tiff_file(@incoming, "#{name}.tif") # Create the file.
      instance_variable_set("@#{name}", file) # Set @a = Pathname(a.tif), etc.
    end
    
    @i = ADC::Importer.new(@incoming.to_s, @archives.to_s)
  end
  
  after do
    @tmpdir.rmtree
  end
  
  it "should take an 'incoming' and an 'archives' path" do
    @i.incoming_path.should == @incoming.to_s
    @i.archives_path.should == @archives.to_s
  end
  
  it "should raise an error if the incoming path doesn't exist" do
    lambda { 
      ADC::Importer.new('nonexistentincomingpath', @archives.to_s) 
    }.should raise_error Errno::ENOENT, /Incoming path '.+' does not exist/
  end
  
  it "should raise an error if the archives path doesn't exist" do
    lambda { 
      ADC::Importer.new(@incoming.to_s, 'nonexistentarchivespath') 
    }.should raise_error Errno::ENOENT, /Archives path '.+' does not exist/
  end
  
  it "should look for new TIF files in 'incoming' and create a directory for their name in 'archives'" do
    @incoming.children.should == [@a, @b ,@c]
    @archives.children.should be_empty
    @i.perform
    @incoming.children.should be_empty
    @archives.children.map { |x| x.basename.to_s }.should == ['a', 'b', 'c']
    @archives.children.first.should be_directory
  end
  
  it "should move TIF files with all common extensions" do
    ['d.tiff', 'e.TIF', 'f.TIFF'].each do |name|
      create_tiff_file(@incoming, name)
    end
    @archives.should have(0).children
    @i.perform
    @archives.should have(6).children
  end
  
  it "should not move non-TIF files" do
    ['d.jpg', 'e.TIF', 'f.txt'].each do |name|
      create_tiff_file(@incoming, name)
    end
    @incoming.should have(6).children
    @archives.should have(0).children
    @i.perform
    @incoming.children.map { |x| x.basename.to_s }.should == ['d.jpg', 'f.txt']
    @archives.should have(4).children
  end
  
  it "should raise an error when trying to import a file with a doc_id that matches an already-imported file" do
    @i.perform
    create_tiff_file(@incoming, 'a.TIFF')
    lambda { @i.perform }.should raise_error Exception, /Can't import, an image with doc_id '.+' already exists/
  end
  
  it "should create Attachment entries in the database for each file it imports" do
    num_fixtures = 5 # This is the number of attachment fixtures.
    Attachment.all.length.should == num_fixtures 
    @i.perform
    Attachment.all.length.should == num_fixtures + 3
  end
  
  it "should create a PDF version of the tif file with the same basename" do
    @i.perform
    (@archives + 'a' + 'a.pdf').should exist
  end
  
  it "should create a PNG thumbnail version of the tif file" do
    @i.perform
    (@archives + 'a' + 'a_H100.png').should exist
  end
end