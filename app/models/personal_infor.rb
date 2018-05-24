class PersonalInfor < ApplicationRecord
  def admin?
     if self.role == "admin"
       return true
     else
       return false
     end
  end
end
