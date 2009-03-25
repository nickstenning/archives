require File.dirname(__FILE__) + '/../test_helper'

class ItemTest < ActiveSupport::TestCase

  def setup
    @book = items(:book)
  end
  
  def test_item_sanity
    assert_kind_of Item, @book
  end
  
  def test_item_description
    assert_not_nil @book.description
    assert_equal "A Book with Three Pages", @book.description
  end
  
  def test_item_item_files
    assert_respond_to @book.item_files, :each
    assert_equal 3, @book.item_files.length
    assert @book.item_files.include?(item_files(:book_page_1))
    assert @book.item_files.include?(item_files(:book_page_2))
    assert @book.item_files.include?(item_files(:book_page_3))
  end
  
  def test_item_description_validation
    @item = Item.new
    
    # Pretend we're on the page for updating the description.
    @item.stage = 'description'
    
    @item.valid?
    assert_equal "can't be blank", @item.errors.on(:description)
    
    @item.description = "Return to the Forbidden Two-Storey House Flyer"
    @item.valid?
    assert_nil @item.errors.on(:description)
  end

end
