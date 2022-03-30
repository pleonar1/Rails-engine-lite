require 'rails_helper'


RSpec.describe "Merchants Reuests", :type => :request do
  it "can get all merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    merchants = JSON.parse(response.body, symbolize_names: true)
    
    expect(response).to be_successful
  end

  it "can get one merchant" do

  end

  it "can get all items for a given merchant id" do

  end
end
