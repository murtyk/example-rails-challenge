require 'rails_helper'

RSpec.feature "Charges", type: :feature do
  context 'search page' do
    before :each do
      @user = FactoryGirl.create(:user, first_name: 'Blah')
      @company = Company.create(name: 'Brown', zip_code: '12345')

      @user.charges.create(FactoryGirl.attributes_for(:successful_charge))
      @user.charges.create(FactoryGirl.attributes_for(:failed_charge))
      @user.charges.create(FactoryGirl.attributes_for(:disputed_charge))

      @company.charges.create(FactoryGirl.attributes_for(:successful_charge))
      @company.charges.create(FactoryGirl.attributes_for(:failed_charge))
      @company.charges.create(FactoryGirl.attributes_for(:disputed_charge))
    end
    after :each do
      @user.destroy
      @company.destroy
    end
    it "finds client and their charges", js: true do
      visit '/charges/search'

      fill_in "charge_client_name", with: 'b'

      expect(page).to have_css('li', text: ChargeServices.user_label(@user))
      expect(page).to have_css('li', text: ChargeServices.company_label(@company))

      fill_in "charge_client_name", with: 'bl'
      expect(page).to have_css('li', text: ChargeServices.user_label(@user))
      expect(page).to_not have_css('li', text: ChargeServices.company_label(@company))

      fill_in "charge_client_name", with: 'br'
      expect(page).to_not have_css('li', text: ChargeServices.user_label(@user))
      expect(page).to have_css('li', text: ChargeServices.company_label(@company))

      label = ChargeServices.company_label(@company)
      page.find('li', text: label).click

      click_on 'Search'

      @company.charges.each do |charge|
        expect(page).to have_text(charge.amount)
      end

      within '#failed_charges_div' do
        expect(page).to have_css('h3', text: 'Failed Charges')
        expect(page).to have_selector('table tr', count: 1)
        expect(page).to have_css('td', text: @company.failed_charges.first.amount)
      end

      within '#disputed_charges_div' do
        expect(page).to have_css('h3', text: 'Disputed Charges')
        expect(page).to have_selector('table tr', count: 1)
        expect(page).to have_css('td', text: @company.disputed_charges.first.amount)
      end

      within '#successful_charges_div' do
        expect(page).to have_css('h3', text: 'Successful Charges')
        expect(page).to have_selector('table tr', count: 1)
        expect(page).to have_css('td', text: @company.successful_charges.first.amount)
      end
    end
  end
end