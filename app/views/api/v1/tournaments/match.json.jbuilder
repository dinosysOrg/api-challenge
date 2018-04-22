json.set! :items do
  json.array! @matches do |match|
    json.partial! "api/v1/common/match", match: match
  end
end
