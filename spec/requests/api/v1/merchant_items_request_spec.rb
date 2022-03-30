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
  end
end
