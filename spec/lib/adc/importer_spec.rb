require File.dirname(__FILE__) + '/../../spec_helper'
require 'tmpdir'
require 'pathname'

describe ADC::Importer do
  before do
    @tmpdir = Pathname(Dir.tmpdir + '/' + rand.to_s[2..8])
    @tmpdir.mkdir
    
    @incoming = @tmpdir + 'incoming'
    @archives = @tmpdir + 'archives'
    
    [@incoming, @archives].each(&:mkdir)
    ['a', 'b', 'c'].each do |name|
      file = @incoming + "#{name}.tif"
      file.open('w')                          # Create the file.
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
    }.should raise_error Errno::ENOENT, /Incoming path '.+' does not exist!/
  end
  
  it "should raise an error if the archives path doesn't exist" do
    lambda { 
      ADC::Importer.new(@incoming.to_s, 'nonexistentarchivespath') 
    }.should raise_error Errno::ENOENT, /Archives path '.+' does not exist!/
  end
  
  it "should look for new TIF files in 'incoming' and move them to 'archives'" do
    @incoming.children.should == [@a, @b ,@c]
    @archives.children.should be_empty
    @i.perform
    @incoming.children.should be_empty
    @archives.children.map(&:basename).should == [@a, @b, @c].map(&:basename)
  end
  
  it "should move TIF files with all common extensions" do
    ['d.tiff', 'e.TIF', 'f.TIFF'].each do |name|
      (@incoming + name).open('w')
    end
    @archives.should have(0).children
    @i.perform
    @archives.should have(6).children
  end
  
  it "should not move non-TIF files" do
    ['d.jpg', 'e.TIF', 'f.txt'].each do |name|
      (@incoming + name).open('w')
    end
    @incoming.should have(6).children
    @archives.should have(0).children
    @i.perform
    @incoming.children.map { |x| x.basename.to_s }.should == ['d.jpg', 'f.txt']
    @archives.should have(4).children
  end
  
  it "should create Attachment entries in the database for each file it imports" do
    num_fixtures = 5 # This is the number of attachment fixtures.
    Attachment.all.length.should == num_fixtures 
    @i.perform
    Attachment.all.length.should == num_fixtures + 3
  end
end