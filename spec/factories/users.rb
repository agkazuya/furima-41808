FactoryBot.define do
  factory :user do
    nickname              { 'テスト' }
    email                 { 'test@example' }
    password              { 'a000000' }
    password_confirmation { 'a000000' }
    first_name            { '田中' }
    last_name             { '太郎' }
    first_name_kana       { 'タナカ' }
    last_name_kana        { 'タロウ' }
    date_of_birth         { '19901111' }
  end
end
