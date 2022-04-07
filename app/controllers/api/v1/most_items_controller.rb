class Api::V1::MostItemsController < ApplicationController

  def index
    number = params[:quantity]
    merchants = Merchant.top_merchants_by_items_sold
  end

end
