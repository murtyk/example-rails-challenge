require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when attributes are invalid' do
    before do
      @user = User.create(first_name: '', last_name: '')
    end
    it 'fails to save' do
      expect(@user.id).to be_nil
      expect(@user.errors.size).to eql(2)
      expect(@user.errors.messages[:first_name][0]).to eql("can't be blank")
      expect(@user.errors.messages[:last_name][0]).to eql("can't be blank")
    end
  end

  context 'when attributes are valid' do
    before do
      @user = User.create(FactoryGirl.attributes_for(:user))
    end
    it 'saves successfully' do
      expect(@user.errors.size).to eql(0)
      expect(@user.id).to be
    end
  end
end
