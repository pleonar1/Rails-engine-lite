require 'rails_helper'

RSpec.describe "Items Requests", :type => :request do
  it "can get all items" do
    merchant1 = create(:merchant)
  	merchant2 = create(:merchant)
  	create_list(:item, 2, merchant_id: merchant1.id)
  	create_list(:item, 2, merchant_id: merchant2.id)

    get "/api/v1/items"

    items = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
  end

  it "can get one item" do

  end

  it "can create an item" do

  end

  it "can edit an item" do

  end

  it "can delete an item" do

  end

  it "can get the merchant data for a gicen item id" do

  end
end
