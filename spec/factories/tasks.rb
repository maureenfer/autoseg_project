FactoryGirl.define do
  factory :task do |f|
    sequence(:name) { |n| "My Task #{n}" }
    sequence(:description) { |n| "My description #{n}" }
    list
  end
end
