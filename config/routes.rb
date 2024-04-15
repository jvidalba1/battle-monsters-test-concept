Rails.application.routes.draw do
  root "monsters#index"
  resources :monsters do
    collection do
      post :import
    end
  end
end
