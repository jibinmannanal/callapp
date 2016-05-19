json.array!(@organizations) do |organization|
  json.extract! organization, :id, :organization_name
  json.url organization_url(organization, format: :json)
end
