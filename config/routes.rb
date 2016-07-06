Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :events, :lectures
  resources :instructions do
    shallow do
      resources :materials
      resources :presentations do
        resources :materials
        resources :questions do
          resources :answers do
            resources :materials
          end
        end
      end
    end
  end

  resources :users
  resources :people
  resource :session do
    member do
      get 'destroy-all'
      post 'destroy-all'
      delete 'destroy-all'
    end
  end
end
