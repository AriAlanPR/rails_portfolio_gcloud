json.extract! weather, :id, :city, :weather, :description, :created_at, :updated_at
json.url weather_url(weather, format: :json)
