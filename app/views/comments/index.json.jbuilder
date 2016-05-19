json.array!(@comments) do |comment|
  json.extract! comment, :id, :comment, :client_id, :organization_name
  json.url comment_url(comment, format: :json)
end
