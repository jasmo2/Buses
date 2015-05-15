Rails.application.routes.draw do
  # resources :users

  
  devise_for :users #, controllers: {registrations: 'users/registrations'}
  root 'users#index'
  
  authenticate :user do
    resources :records, except: [:index]
    resources :bus_routes do
      collection { post :import }
    end
    get '/programacion' => 'buses#index' ,as: :programacion
    resources :buses, except: [:index] do
      collection { post :import }
    end
    get '/autobuses' => 'buses#list_buses'

  end
  post '/checkpoint' => 'users#checkpoint' ,as: :user_checkpoint
  get '/usuarios' => 'users#list_users'
  scope "/coonatra" do
    resources :users, except: [:index,:show,:update]
    resources :users, only: [] do
      collection do
        get ':id/autobuses' => 'users#bus_list' ,as: :bus_list
        patch 'autobuses' => 'buses#bus_assignment' ,as: :bus_assignment
      end
    end

  end
end
