class Api::V1::ItemsController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.all)

    #eventually define status codes
  end
end
