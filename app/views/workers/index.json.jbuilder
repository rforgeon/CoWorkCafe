json.array!(@workers) do |worker|
  json.extract! worker, :id, :user_id, :count
  json.url worker_url(worker, format: :json)
end
