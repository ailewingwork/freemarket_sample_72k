FactoryBot.define do

  factory :profile do
    profile               {"自己紹介です。"}
    family_name           {"田中"}
    first_name            {"太郎"}
    family_name_kana      {"タナカ"}
    first_name_kana       {"タロウ"}
    birth_day             {"1989-01-01"}
    mobile                {"0901000002"}
  end
end