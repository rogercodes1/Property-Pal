class Tenant < ApplicationRecord
  has_secure_password
  belongs_to :unit, optional: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  def fullname
    self.first_name + " " + self.last_name
  end

  def verify_unit
    if !self.unit_id.nil?
      return true
    else
      return false
    end
  end

  def sector
      Sector.try(:find, self.unit.sector_id)
  end

  def property
    Property.try(:find, self.unit.sector.property_id)
  end
end
