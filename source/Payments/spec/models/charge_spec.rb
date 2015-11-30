require 'rails_helper'

RSpec.describe Charge, type: :model do
  context 'when invalid attributes' do
    before do
      # chargable is null
      @charge = Charge.create(FactoryGirl.attributes_for(:successful_charge))
    end
    it 'fails to save' do
      expect(@charge.errors.size).to eql(1)
    end
  end

  context 'when attributes are valid' do
    before do
      user = FactoryGirl.create(:user)
      @charge = user.charges.create(FactoryGirl.attributes_for(:successful_charge))
    end
    it 'saves successfully' do
      expect(@charge.errors.size).to eql(0)
      expect(@charge.id).to be
    end
  end
end
