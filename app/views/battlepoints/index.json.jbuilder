json.array!(@battlepoints) do |battlepoint|
  json.extract! battlepoint, :id, :battle_id, :hashtag, :count
  json.url battlepoint_url(battlepoint, format: :json)
end
