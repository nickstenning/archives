class OrganisationRole < ActiveRecord::Base
  
  belongs_to :organisation
  belongs_to :person
  
end
