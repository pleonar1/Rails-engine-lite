class ItemsSoldSerializer
  include JSONAPI::Serializer
  attributes :name

  attribute :count do |object|
    object.items_sold
  end
end
