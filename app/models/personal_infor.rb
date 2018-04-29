class PersonalInfor < ApplicationRecord
  def admin?
    self.role == "admin"
  end
end
