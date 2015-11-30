class ChargeServices
  class << self
    def search(client_type, id)
      client = client_type == 'user' ? User.find(id) : Company.find(id)

      {
        failed_charges: for_json(client.failed_charges),
        disputed_charges: for_json(client.disputed_charges),
        successful_charges: for_json(client.successful_charges)
      }
    end

    def for_json(charges)
      charges.select(:amount, :created_at)
        .map { |charge| { amount: charge.amount, date: charge.date } }
    end

    def search_clients(term)
      name = term + '%'

      users
        .where('first_name ilike ? or last_name ilike ?', name, name)
        .map { |user| user_label(user) } +

      companies
        .where('name ilike ?', name)
        .map { |company| company_label(company) }
    end

    def users
      User.where(id: client_ids('User'))
    end

    def companies
      Company.where(id: client_ids('Company'))
    end

    def client_ids(type = nil)
      Charge.select(:chargable_id).where(chargable_type: type).uniq
    end

    def user_label(user)
      user.to_label + "---user:" + user.id.to_s
    end

    def company_label(company)
      company.to_label + '---company:' + company.id.to_s
    end
  end
end