Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope :path => '/api/v1/', :module => "api_v1", :as => 'v1', :defaults => { :format => :json } do
    match "login", to: "auth#login", via: [:post, :options]
    post "logout" => "auth#logout"
    post "register" => "register#create", :as => 'user'
  end

  get "index" => "index#main"

  resources :managecourse, :controller => 'managecourse'
  resources :info, :controller => 'info'
  resources :course, :controller => 'course'

  get "feature/search/:query" => "feature#search"

  root :to => "index#main"

end
