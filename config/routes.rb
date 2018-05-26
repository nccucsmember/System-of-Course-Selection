Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope :path => '/api/v1/', :module => "api_v1", :as => 'v1', :defaults => { :format => :json } do
    match "login", to: "auth#login", via: [:post, :options]
    match "logout", to: "auth#logout", via: [:post, :options]
    match "register", to: "register#create", via: [:post, :options]
  end

  get "index" => "index#main"

  resources :managecourse, :controller => 'managecourse'
  resources :info, :controller => 'info'
  resources :course, :controller => 'course'
  resources :choose, :controller => 'choose'

  get "feature/search/:query" => "feature#search"
  get "course/search/:query" => "course#search"

  root :to => "index#main"

end
