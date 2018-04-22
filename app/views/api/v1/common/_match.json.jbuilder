if match
  json.id                       match.id
  json.tournament_id            match.tournament_id
  json.group_id                 match.group_id
  json.code                     match.code
  json.date                     match.date
  json.time                     match.time.strftime("%H:%M:%S")
  json.venue                    match.venue
end
