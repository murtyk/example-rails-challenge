require 'rails_helper'

RSpec.describe Company, type: :model do
  context 'when attributes are invalid' do
    before do
      @company = Company.create(name: '', zip_code: '')
    end
    it 'fails to save' do
      expect(@company.errors.size).to eql(2)
      expect(@company.errors.messages[:name][0]).to eql("can't be blank")
      expect(@company.errors.messages[:zip_code][0]).to eql("can't be blank")
    end
  end
end