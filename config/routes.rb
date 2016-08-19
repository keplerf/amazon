Rails.application.routes.draw do
  get "/home" => "home#index"
  get "/about_us" => "home#about_us", as: :about_us
  get "/contact" => "contact#contact", as: :contact
  post "/contact" => "contact#thankyou",  as: :thankyou
  root "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :products do
    # get "/questions/new" => "questions#new", as: :new_question
    # post "/questions" => "questions#create", as: :questions
    # get "/questions/:id" => "questions#show",   as: :question
    # get "/questions" => "questions#index"
    # get "/questions/:id/edit" => "questions#edit",   as: :edit_question
    # patch "/questions/:id" => "questions#update"
    # delete "/questions/:id" => "questions#destroy"
    resources :reviews, only: [:index, :create, :destroy]
  end
end
