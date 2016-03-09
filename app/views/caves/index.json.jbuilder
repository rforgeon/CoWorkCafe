json.array!(@caves) do |cafe|
  json.extract! cafe, :id, :name, :description, :address, :city, :state, :zipcode
  json.url cafe_url(cafe, format: :json)
end
