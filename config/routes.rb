Rails.application.routes.draw do
  resources :me_demos do
    get :grab
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
