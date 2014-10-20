json.array!(@battles) do |battle|
  json.extract! battle, :id, :hashtag1, :hashtag2, :user_id, :since_number, :status, :ends_at
  json.url battle_url(battle, format: :json)
end
