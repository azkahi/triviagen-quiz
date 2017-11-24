json.array!(@new_trivia) do |new_trivium|
  json.extract! new_trivium, :id, :content, :title
  json.url new_trivium_url(new_trivium, format: :json)
end
