FactoryBot.define do
  factory :user do
    trait :player_mz do
      id { 1 }
      name { "Mark Zuckerberg" }
    end

    trait :player_cc do
      id { 2 }
      name { "Chip Conley" }
    end

    trait :player_jd do
      id { 3 }
      name { "John Doerr" }
    end
  end
end
