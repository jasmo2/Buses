Rails.application.routes.draw do
  # resources :users
  
  devise_for :users, skip: [:registrations]
  root 'users#index'
  
  authenticate :user do
    resources :records, except: [:index]
    get 'datos-de-registro' => 'records#search' ,as: :data_list
    post 'traer-records' => 'records#data_list', as: :get_records
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
    resources :users, except: [:index,:show]
    resources :users, only: [] do
      collection do
        get ':id/autobuses' => 'users#bus_list' ,as: :bus_list
        post 'autobuses' => 'buses#bus_assignment' ,as: :bus_assignment
      end
    end

  end
end
