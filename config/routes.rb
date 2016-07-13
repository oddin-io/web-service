Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :user
  resource :person
  resource :session do
    member do
      get 'destroy-all'
      post 'destroy-all'
      delete 'destroy-all'
    end
  end

  resources :materials, only: [:show, :destroy]
  concern :materializable do
    resources :materials, except: [:show, :destroy, :update] do
      collection do
        get 'new'
      end
    end
  end

  resources :events, :lectures
  resources :instructions, concerns: :materializable do
    shallow do
      resources :presentations, concerns: :materializable do
        resources :questions do
          resources :answers, concerns: :materializable do
          end
        end
      end
    end
  end
end
