require 'rails_helper'

RSpec.describe "Merchant Items Reuests", :type => :request do
  it "can get all items for a given merchant id" do
    merchant1 = create(:merchant)
		merchant2 = create(:merchant)
		create_list(:item, 2, merchant_id: merchant1.id)
		create_list(:item, 2, merchant_id: merchant2.id)

    get "/api/v1/merchants/#{merchant1.id}/items"

    merchant_items = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(merchant_items).to have_key(:data)
    merchant_items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item).to have_key(:type)
      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes]).to have_key(:merchant_id)
    end
  end
end
