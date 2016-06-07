FactoryGirl.define do
  factory :user, :class => 'User' do |f|
    sequence (:id)
    sequence(:email) { |n| "email#{n}@email.com" }
    f.password "pass123"
    f.password_confirmation "pass123"
  end
end
