class Api::V1::MerchantItemsController < ApplicationController

  def index
    render json: MerchantItemSerializer.new(MerchantItem.all)
  end
end
