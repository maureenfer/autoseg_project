Rails.application.routes.draw do
  root 'home#index'
  devise_for :users
  resources  :lists
  resources  :tasks
  resources  :favorites

  match 'add-favorite/:list_id', to: 'favorites#add_favorite_list', via: :get
  get 'list_stream' => 'lists#notification'
end
