json.set! :item do
  json.won_matches          @result[:won_matches]
  json.lost_matches         @result[:lost_matches]
  json.drawn_matches        @result[:drawn_matches]
  json.point                @result[:points]
end
