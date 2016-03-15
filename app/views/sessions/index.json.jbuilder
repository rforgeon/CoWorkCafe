json.array!(@sessions) do |session|
  json.extract! session, :id, :start, :finish
  json.url session_url(session, format: :json)
end
