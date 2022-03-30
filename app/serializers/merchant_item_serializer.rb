class MerchantItemSerializer
  include JSONAPI::Serialize
  attributes :name, :description, :unit_price, :merchant_id
end
