require File.dirname(__FILE__) + '/../spec_helper'

describe "Item" do
  fixtures :items, :attachments

  before do
    @book = items(:book)
  end
  
  it "should have a description" do
    @book.description.should == "A Book with Three Pages"
  end
  
  it "should have a list of attachments" do
    @book.attachments.should respond_to(:each)
    @book.attachments.length.should == 3
    @book.attachments.should include(attachments(:book_page_1))
    @book.attachments.should include(attachments(:book_page_2))
    @book.attachments.should include(attachments(:book_page_3))
  end
  
  it "should not allow a blank description" do
    @item = Item.new
    
    # Pretend we're on the page for updating the description.
    @item.stage = 'description'
    
    @item.valid?
    @item.errors.on(:description).should == "can't be blank"
    
    @item.description = "Return to the Forbidden Two-Storey House Flyer"
    @item.valid?
    @item.errors.on(:description).should == nil
  end
  
  it "should have a list of shows associated through ItemLinkings" do
    item = Item.new
    show = mock_model(Show)
    Show.should_receive(:find).and_return([show])

    item.shows.should == [show]
  end
  
  it "should have a list of people associated through ItemLinkings" do
    item = Item.new
    pers = mock_model(Person)
    Person.should_receive(:find).and_return([pers])

    item.people.should == [pers]
  end
  
  it "should have a list of organisations associated through ItemLinkings" do
    item = Item.new
    org = mock_model(Organisation)
    Organisation.should_receive(:find).and_return([org])

    item.organisations.should == [org]
  end

end
