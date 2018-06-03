Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope :path => '/api/v1/', :module => "api_v1", :as => 'v1', :defaults => { :format => :json } do
    match "login", to: "auth#login", via: [:post, :options]
    match "logout", to: "auth#logout", via: [:post, :options]
    match "register", to: "register#create", via: [:post, :options]
  end

  get "index" => "index#main"

  match "managecourse", to: "managecourse#index", via: [:get, :options]
  match "managecourse/:id", to: "managecourse#update", via: [:put, :options]
  match "managecourse/:id", to: "managecourse#destroy", via: [:delete, :options]

  match "choose", to: "choose#index", via: [:get, :options]
  match "choose/:id", to: "choose#update", via: [:put, :options]
  match "choose/:id", to: "choose#destroy", via: [:delete, :options]

  match "comment/:id/ascent", to: "comment#ascent", via: [:get, :options]
  match "comment/:id/descent", to: "comment#descent", via: [:get, :options]
  match "comment/:id/time_ascent", to: "comment#time_ascent", via: [:get, :options]
  match "comment/:id/time_descent", to: "comment#time_descent", via: [:get, :options]
  match "comment/:id/score", to: "comment#score", via: [:get, :options]
  match "comment/:id/:comment_id", to: "comment#give_thumbup", via: [:put, :options]
  match "comment/:id/:comment_id", to: "comment#remove_thumbup", via: [:delete, :options]

  resources :info, :controller => 'info'
  resources :course, :controller => 'course'

  get "feature/search/:query" => "feature#search"
  get "course/search/:query" => "course#search"

  root :to => "index#main"

end
