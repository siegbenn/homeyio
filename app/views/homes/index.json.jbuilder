json.array!(@homes) do |home|
  json.extract! home, :address, :city, :state, :zip
  json.url home_url(home, format: :json)
end
