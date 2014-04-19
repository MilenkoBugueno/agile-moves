AgileMovesOs::Application.routes.draw do



  scope "(:locale)" do                   #To change the url from for example http://localhost:3000/users/edit?locale=en
                                      # to http://localhost:3000/en/users/edit
  resources :projects do
    collection do
      get 'work'
      get 'report'
    end
       end
  resources :capacities

  resources :interruptions

  resources :states

  resources :ratings

  resources :move_types

  resources :moves do
    resources :ratings
    resources :tomatoes do
      collection do
        put :done
        put :move
      end
    end
    collection do
      put :move
    end
  end
  
  resources :tomatoes do
    resources :interruptions
    resources :ratings
    collection do
      put :done
      put :move
    end
  end

  resources :live_tomatoes

  get '/de/live_refresh' => 'live_tomatoes#index'
  get '/en/live_refresh' => 'live_tomatoes#index'

  authenticated :user do
    root :to => 'projects#index'
  end
  root :to => "projects#index"
  devise_for :users
  resources :users
  end
end