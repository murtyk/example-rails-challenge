class User < ActiveRecord::Base
  has_many :charges, as: :chargable, dependent: :destroy

  validates_presence_of :first_name
  validates_presence_of :last_name

  def to_label
    first_name + " " + last_name
  end

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
