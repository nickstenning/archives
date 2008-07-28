require File.dirname(__FILE__) + '/../test_helper'

class ItemTest < ActiveSupport::TestCase

  def setup
    @book = items(:book)
  end
  
  def test_item_sanity
    assert_kind_of Item, @book
  end
  
  def test_item_name
    assert_not_nil @book.name
    assert_equal "A Book with Three Pages", @book.name
  end
  
  def test_item_item_files
    assert_respond_to @book.item_files, :each
    assert_equal 3, @book.item_files.length
    assert @book.item_files.include?(item_files(:book_page_1))
    assert @book.item_files.include?(item_files(:book_page_2))
    assert @book.item_files.include?(item_files(:book_page_3))
  end
  
  def test_item_name_validation
    @item = Item.new
    
    @item.valid?
    # An Item with no name should NOT be valid
    assert_equal "can't be blank", @item.errors.on(:name)
    
    @item.name = "A History of the Amateur Dramatic Club..."
    @item.valid?
    # An Item with a name should be valid
    assert_nil @item.errors.on(:name)
  end

end
