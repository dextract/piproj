json.array!(@visuals) do |visual|
  json.extract! visual, :id, :type, :youtube-id, :description, :user_id
  json.url visual_url(visual, format: :json)
end
