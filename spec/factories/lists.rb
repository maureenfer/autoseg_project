FactoryGirl.define do
  factory :list do |f|
    sequence(:name) { |n| "My List #{n}" }
    f.status false
    f.user_id 1 

    factory :task_with_lists do
        transient do
            tasks_count = 5
        end

        after(:create) do |list, evaluator|
            create_list(:task, evaluator.lists_count, list: list)
        end
    end
  end
end 