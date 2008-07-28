class OrganisationRole < ActiveRecord::Base
  
  belongs_to :organisation
  belongs_to :person
  
  validates_presence_of :name, :message => "can't be blank"
  
end
