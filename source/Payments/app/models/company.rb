class Company < ActiveRecord::Base
  has_many :charges, as: :chargable, dependent: :destroy

  validates_presence_of :name
  validates_presence_of :zip_code

  def to_label
    "#{name} #{zip_code}"
  end

  # we need to refactor these. user has same methods.
  def failed_charges
    charges.where(paid: false)
  end

  def disputed_charges
    charges.where(paid: true, refunded: true)
  end

  def successful_charges
    charges.where(paid: true, refunded: false)
  end
end
