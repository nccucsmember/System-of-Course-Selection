Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "index/welcome" => "index#welcome"
  get "index" => "index#main"

  resources :managecourse, :controller => 'managecourse'
  resources :info, :controller => 'info'

  root :to => "index#main"

end
