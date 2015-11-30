require 'rails_helper'

RSpec.describe Charge, type: :model do
  describe 'creation' do
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

  describe 'charge has valid status' do
    before do
      @user = FactoryGirl.create(:user)
    end
    context 'created with different statuses' do
      before do
        @successful_charge =
          @user.charges.create(FactoryGirl.attributes_for(:successful_charge))

        @failed_charge =
          @user.charges.create(FactoryGirl.attributes_for(:failed_charge))

        @disputed_charge =
          @user.charges.create(FactoryGirl.attributes_for(:disputed_charge))
      end

      it 'returns valid status' do
        expect(@successful_charge.status).to eql(:SUCCESSFUL)
        expect(@failed_charge.status).to eql(:FAILED)
        expect(@disputed_charge.status).to eql(:DISPUTED)
      end

      it 'responds to status query' do
        expect(@successful_charge.successful?).to be_truthy
        expect(@failed_charge.failed?).to be_truthy
        expect(@disputed_charge.disputed?).to be_truthy

        expect(@successful_charge.failed?).to_not be_truthy
      end
    end
  end

  describe 'charge has valid scopes' do
    before do
      @user = FactoryGirl.create(:user)
    end
    context 'created with different statuses' do
      before do
        2.times do
          @user.charges.create(FactoryGirl.attributes_for(:successful_charge))
        end

        3.times do
          @user.charges.create(FactoryGirl.attributes_for(:failed_charge))
        end

        4.times do
          @user.charges.create(FactoryGirl.attributes_for(:disputed_charge))
        end
      end

      it 'returns by status' do
        expect(Charge.successful.count).to eql(2)
        expect(Charge.failed.count).to eql(3)
        expect(Charge.disputed.count).to eql(4)
      end
    end
  end
end
