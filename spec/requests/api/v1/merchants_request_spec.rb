require 'rails_helper'

RSpec.describe "Merchants Reuests", :type => :request do
  it "can get all merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(merchants).to have_key(:data)
    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant).to have_key(:type)
      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes]).to have_key(:name)
    end
    expect(merchants[:data].count).to eq(3)
  end

  it "can get one merchant" do
    create_list(:merchant, 2)
    merchant1 = Merchant.first
    merchant2 = Merchant.last

    get "/api/v1/merchants/#{merchant1.id}"

    merchant = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data]).to have_key(:type)
    expect(merchant[:data]).to have_key(:attributes)
    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data].count).to eq(3)
    expect(merchant[:id]).to_not eq(merchant2.id)
  end
end
