# This is the core mechanism by which our polymorphic Item <- (Objects) 
# relationship works. 
# 
# 1. Each item has_many instances of class ItemLinking.
# 2. Each instance of ItemLinking has an item_linking method, which returns
#    the object with which it's linked.
# --
# 3. Each instance of an object with a polymorphic association to Item, e.g.
#    Person, has_many item_linkings
#
class ItemLinking < ActiveRecord::Base
  
  belongs_to :item
  belongs_to :linked_object, :polymorphic => true

end
