class ChargesController < ApplicationController
  def client_names
    clients = ChargeServices.search_clients(params[:term])
    render(json: clients, status: :ok)
  end

  def search
    return unless params[:client_type]

    @charges = ChargeServices.search(params[:client_type], params[:client_id])
    render(json: @charges, status: :ok)
  end

  def index
    @successful_charges = Charge.successful.includes(:chargable)
    @failed_charges     = Charge.failed.includes(:chargable)
    @disputed_charges   = Charge.disputed.includes(:chargable)
  end

  def show
    @charge = Charge.find_by(unique_code: params[:unique_code])
  end

  def new
    @charge = Charge.new
  end

  def create
    @charge = ChargeFactory.create(charge_params)

    if @charge.errors.empty?
      redirect_to @charge, notice: 'Charge was successfully created.'
    else
      render :new
    end
  end

  private

  def charge_params
    params.require(:charge).permit(:user_id, :company_id, :amount)
  end
end