Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  get "index" => "index#main"

  resources :managecourse, :controller => 'managecourse'
  resources :info, :controller => 'info'
  resources :course, :controller => 'course'

  root :to => "index#main"

end
