Rails.application.routes.draw do
  post '/recover-password', to: 'people#recover_password'
  post '/redefine-password', to: 'people#redefine_password'

  resource :person
  resource :session do
    member do
      delete 'delete-all'
    end
  end

  resources :materials, only: [:show, :destroy, :update]
  concern :materializable do
    resources :materials
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
            collection do
              post 'materials', to: 'answers#create_only_material'
            end

            member do
              post 'accept'
              delete 'accept', to: 'answers#undo_accept'
            end
          end
        end
      end
    end
  end
end
