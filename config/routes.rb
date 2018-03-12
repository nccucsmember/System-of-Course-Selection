Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "index/welcome" => "index#welcome"
  get "index" => "index#main"

  root :to => "index#main"

end
