class User < ActiveRecord::Base
  
  belongs_to :person
  
  def self.find_or_create_by_camdram_result( result )
    if user = self.find_by_camdram_number( result[:number] )
      user
    else
      self.create(:camdram_number => result[:number],
                  :camdram_loginname => result[:loginname],
                  :camdram_realname => result[:realname])
    end
  end  
  
  def name
    if person
      person.name
    else
      self.camdram_realname
    end
  end
  
end
