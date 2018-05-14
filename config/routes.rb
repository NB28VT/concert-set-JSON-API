Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :concerts, only: [:index, :show]
      resources :songs, only: [:index, :show]
      resources :venues, only: [:index, :show] do
        member do
          get :concerts
        end
      end
    end
  end

end
