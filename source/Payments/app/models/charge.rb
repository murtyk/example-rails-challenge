class Charge < ActiveRecord::Base
  belongs_to :chargable, polymorphic: true

  validates_presence_of :amount
  validates_presence_of :chargable

  before_create :generate_unique_code

  private

  def generate_unique_code
    self.unique_code = SecureRandom.urlsafe_base64(10)
  end
end
