json.array!(@owners) do |owner|
  json.extract! owner, :id, :user_id, :address, :state, :city, :zipcode, :description, :rating
  json.url owner_url(owner, format: :json)
end
