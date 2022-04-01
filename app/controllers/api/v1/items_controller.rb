class Api::V1::ItemsController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.all)

    #eventually define status codes
  end

  def show
    if Item.exists?(params[:id])
      render json: ItemSerializer.new(Item.find(params[:id]))
    else
      render :status => 404
    end
  end

  def create
    item = Item.create(item_params)
    if item.id.nil?
      render :status => 404
    else
      render json: ItemSerializer.new(item), status: :created
    end
  end

  def update
    if Item.exists?(params[:id])
      item = Item.find(params[:id])
      if item.update(item_params)
        render json: ItemSerializer.new(item)
      else
        render :status => 404
      end
    else
      render :status => 404
    end
  end

  def destroy
    if Item.exists?(params[:id])
     render json: Item.delete(params[:id])
   else
     render :status => 404
   end
  end

  private

    def item_params
      params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
    end
end
