Rails.application.routes.draw do
  root 'home#index'
  devise_for :users

  authenticate :user do
    resources  :lists
    resources  :tasks, type: 'Task'
    resources  :subtasks, controller: 'tasks', type: 'Subtask'
    resources  :favorites

    match 'add-favorite/:list_id', to: 'favorites#add_favorite_list', via: :get
    get 'list_stream' => 'lists#notification'
    
  end
end
