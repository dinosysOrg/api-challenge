FactoryBot.define do
  factory :match do
    trait :mz_gave_up do
      id { 1 }
      tournament_id { 1 }
      group_id { 1 }
      venue_id { 1 }
      player_1_id { 2 }
      player_2_id { 1 }
      score { "Mark Zuckerberg gave up" }
      match_code { "C1-1-2" }
    end

    trait :player_mz_win do
      id { 2 }
      tournament_id { 1 }
      group_id { 1 }
      venue_id { 1 }
      player_1_id { 1 }
      player_2_id { 2 }
      score { "1-0" }
      match_code { "C1-1-3" }
    end

    trait :player_mz_lost do
      id { 3 }
      tournament_id { 1 }
      group_id { 1 }
      venue_id { 1 }
      player_1_id { 1 }
      player_2_id { 2 }
      score { "0-1" }
      match_code { "C1-2-3" }
    end

    trait :player_jd_and_cc_drawn do
      id { 3 }
      tournament_id { 1 }
      group_id { 1 }
      venue_id { 1 }
      player_1_id { 2 }
      player_2_id { 3 }
      score { "1-1" }
      match_code { "C1-2-3" }
    end

    trait :drawn do
      id { 4 }
      tournament_id { 1 }
      group_id { 1 }
      venue_id { 1 }
      player_1_id { 2 }
      player_2_id { 1 }
      score { "1-1" }
      match_code { "C2-1-2" }
    end
  end
end
