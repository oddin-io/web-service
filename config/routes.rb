Rails.application.routes.draw do
  post '/recover-password', to: 'people#recover_password'
  post '/redefine-password', to: 'people#redefine_password'

  resources :people
  resources :teste
  resource :session do
    member do
      delete 'delete-all'
    end
  end

  resources :enrolls

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

  resources :alternatives, only: [] do
    member do
      post 'choose', to: 'surveys#choose'
    end
  end

  resources :events do
    member do
      get 'instructions'
    end
  end
  resources :lectures
  shallow do
    resources :instructions, concerns: :materializable do
      member do
        get 'profile'
        get 'participants'
      end

      resources :tests do
        resources :test_questions
        resources :test_responses do
          resources :test_answers
        end
      end
      
      resources :notices
      resources :faqs, except: [:show]
      resources :surveys do
        member do
          post 'close'
        end
      end

      resources :dates, controller: 'calendars'
      resources :works, concerns: :materializable do
        resources :submissions, concerns: :materializable
      end
      resources :presentations, concerns: :materializable do
        member do
          post 'close'
        end
        resources :requests
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
        resources :cluster, controller: 'cluster'
        resources :faqs, controller: 'presentation_faq'
      end
    end
  end
end
