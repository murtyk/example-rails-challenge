class User < ActiveRecord::Base
  has_many :charges, as: :chargable, dependent: :destroy

  validates_presence_of :first_name
  validates_presence_of :last_name
end
