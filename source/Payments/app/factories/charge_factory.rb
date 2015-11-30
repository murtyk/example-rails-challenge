class ChargeFactory
  class << self
    def create(params)
      user_id    = params[:user_id]
      company_id = params[:company_id]
      amount     = params[:amount]

      return no_chargable_charge(amount) if user_id.blank? && company_id.blank?

      chargable = User.find(user_id) unless user_id.blank?
      chargable = Company.find(company_id) unless company_id.blank?

      chargable.charges.create(amount: amount)
    end

    def no_chargable_charge(amount)
      charge = Charge.new(amount: amount)
      charge.errors.add(:base, 'You must select an user OR a company')
      charge
    end
  end
end
