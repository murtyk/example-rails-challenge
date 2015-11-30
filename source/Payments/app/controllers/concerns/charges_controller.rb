class ChargesController < ApplicationController
  def index
    @successful_charges = Charge.successful.includes(:chargable)
    @failed_charges     = Charge.failed.includes(:chargable)
    @disputed_charges   = Charge.disputed.includes(:chargable)
  end

  def show
    @charge = Charge.find_by(unique_code: params[:unique_code])
  end
end