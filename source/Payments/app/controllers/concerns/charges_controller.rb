class ChargesController < ApplicationController
  def index
    @successful_charges = Charge.successful.includes(:chargable)
    @failed_charges     = Charge.failed.includes(:chargable)
    @disputed_charges   = Charge.disputed.includes(:chargable)
  end
end