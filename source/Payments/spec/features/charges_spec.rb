require 'rails_helper'

RSpec.feature "Charges", type: :feature do
  context 'index page' do
    before do
      @user = FactoryGirl.create :user
      @company = FactoryGirl.create :company

      [@user, @company].each do |client|
        client.charges.create(FactoryGirl.attributes_for(:successful_charge))
        client.charges.create(FactoryGirl.attributes_for(:failed_charge))
        client.charges.create(FactoryGirl.attributes_for(:disputed_charge))
      end
    end

    it 'lists all charges in respective tables' do
      visit '/charges'

      # in each div:
      #   1. header h1
      #   2. 2 rows
      #   3. user name
      #   4. company name

      within '#failed_charges_div' do
        expect(page).to have_css('h1', text: 'Failed Charges')

        expect(page).to have_selector('table tr', count: 2)
        expect(page).to have_css('td', text: @user.to_label)
        expect(page).to have_css('td', text: @company.to_label)
      end

      within '#disputed_charges_div' do
        expect(page).to have_css('h1', text: 'Disputed Charges')

        expect(page).to have_selector('table tr', count: 2)
        expect(page).to have_css('td', text: @user.to_label)
        expect(page).to have_css('td', text: @company.to_label)
      end

      within '#successful_charges_div' do
        expect(page).to have_css('h1', text: 'Successful Charges')

        expect(page).to have_selector('table tr', count: 2)
        expect(page).to have_css('td', text: @user.to_label)
        expect(page).to have_css('td', text: @company.to_label)
      end
    end
  end
end
