require File.dirname(__FILE__) + '/../test_helper'

class ItemFileTest < ActiveSupport::TestCase
  
  def setup
    @book_page_2 = item_files(:book_page_2)
  end
  
  def test_item_file_sanity
    assert_kind_of ItemFile, @book_page_2
  end
  
  def test_item_file_url
    assert_not_nil @book_page_2.url
    assert_equal "http://scanstore/book/page_2.pdf", @book_page_2.url
  end
  
  def test_item_file_item
    assert_not_nil @book_page_2.item
    assert_equal items(:book), @book_page_2.item
  end
  
  def test_item_file_url_validation
    @item_file = ItemFile.new
    
    @item_file.valid?
    # An ItemFile with no URL should NOT be valid
    assert_equal "can't be blank", @item_file.errors.on(:url)
    
    @item_file.url = "file:///path/to/file"
    @item_file.valid?
    # An ItemFile with a URL should be valid
    assert_nil @item_file.errors.on(:url)
  end
  
end
