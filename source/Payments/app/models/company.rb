class Company < ActiveRecord::Base
  has_many :charges, as: :chargable, dependent: :destroy

  validates_presence_of :name
  validates_presence_of :zip_code

  def to_label
    "#{name} #{zip_code}"
  end
end
