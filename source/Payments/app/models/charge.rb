class Charge < ActiveRecord::Base
  belongs_to :chargable, polymorphic: true

  scope :successful, -> { where(paid: true, refunded: false) }
  scope :disputed,   -> { where(paid: true, refunded: true) }
  scope :failed,     -> { where(paid: false) }

  validates_presence_of :amount
  validates_presence_of :chargable

  before_create :generate_unique_code

  def to_param
    unique_code
  end

  def client_name
    chargable.try(:to_label)
  end

  def date
    created_at.strftime('%m/%d/%Y')
  end

  def status
    return :SUCCESSFUL if successful?
    return :DISPUTED if disputed?
    :FAILED
  end

  def successful?
    paid && !refunded
  end

  def disputed?
    paid && refunded
  end

  def failed?
    !paid
  end

  private

  def generate_unique_code
    self.unique_code = SecureRandom.urlsafe_base64(10)
  end
end
