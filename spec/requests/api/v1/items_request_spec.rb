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
    expect(items).to have_key(:data)
    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item).to have_key(:type)
      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a String
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a String
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a Float
      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_a Integer
    end
  end

  it "can get one item" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    item1 = create(:item, merchant_id: merchant1.id)
    create_list(:item, 2, merchant_id: merchant2.id)

    get "/api/v1/items/#{item1.id}"

    item = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(item).to have_key(:data)
    expect(item[:data]).to have_key(:id)
    expect(item[:data]).to have_key(:type)
    expect(item[:data]).to have_key(:attributes)
    expect(item[:data][:attributes][:name]).to eq(item1.name)
    expect(item[:data][:attributes][:name]).to be_a String
    expect(item[:data][:attributes][:description]).to eq(item1.description)
    expect(item[:data][:attributes][:description]).to be_a String
    expect(item[:data][:attributes][:unit_price]).to eq(item1.unit_price)
    expect(item[:data][:attributes][:unit_price]).to be_a Float
    expect(item[:data][:attributes][:merchant_id]).to eq(item1.merchant_id)
    expect(item[:data][:attributes][:merchant_id]).to be_a Integer
  end

  it "can create an item" do
    merchant1 = create(:merchant)
    item_params = {
                  "name": "value1",
                  "description": "value2",
                  "unit_price": 100.99,
                  "merchant_id": merchant1.id
                  }
    headers = { 'CONTENT_TYPE' => 'application/json' }

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    created_item = Item.last

    expect(response).to be_successful
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end

  it "can edit an item" do
    merchant1 = create(:merchant)
    item1 = create(:item, merchant_id: merchant1.id)
    item_params = {
                  "name": "value1",
                  "description": "value2",
                  "unit_price": 100.99,
                  "merchant_id": merchant1.id
                  }
    headers = { 'CONTENT_TYPE' => 'application/json' }

    patch "/api/v1/items/#{item1.id}", headers: headers, params: JSON.generate(item: item_params)

    expect(response).to be_successful
    updated_item = Item.find_by(id: item1.id)
    expect(updated_item.name).to eq(item_params[:name])
    expect(updated_item.description).to eq(item_params[:description])
    expect(updated_item.unit_price).to eq(item_params[:unit_price])
    expect(updated_item.merchant_id).to eq(item_params[:merchant_id])
  end

  it "can delete an item" do

  end

  it "can get the merchant data for a given item id" do

  end
end
