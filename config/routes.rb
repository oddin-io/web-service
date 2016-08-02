Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :user
  resource :person
  resource :session do
    member do
      delete 'delete-all', method: 'destroy_all'
    end
  end

  resources :materials, only: [:show, :destroy, :update]
  concern :materializable do
    resources :materials, except: [:create, :show, :destroy, :update] do
      collection do
        get 'new'
      end
    end
  end

  concern :votable do
    member do
      post 'upvote'
      post 'downvote'
      delete 'vote'
    end
  end

  resources :events, :lectures
  resources :instructions, concerns: :materializable do
    member do
      get 'profile'
      get 'participants'
    end
    shallow do
      resources :presentations, concerns: :materializable do
        member do
          post 'close'
        end
        resources :questions, concerns: :votable do
          resources :answers, concerns: [:materializable, :votable] do
          end
        end
      end
    end
  end
end
