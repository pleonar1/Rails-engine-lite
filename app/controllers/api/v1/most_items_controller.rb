class Api::V1::MostItemsController < ApplicationController

  def index
    number = params[:quantity]
    merchants = Merchant.top_merchants_by_items_sold(number)
    if !params[:quantity]
      render json: JSON.generate({error: "error"}), status: 400
    else
      render json: ItemsSoldSerializer.new(merchants)
    end
  end
end
