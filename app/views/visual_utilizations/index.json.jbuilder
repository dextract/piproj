json.array!(@visual_utilizations) do |visual_utilization|
  json.extract! visual_utilization, :id, :content_id, :visual_id
  json.url visual_utilization_url(visual_utilization, format: :json)
end
