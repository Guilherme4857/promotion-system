Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users

  resources :promotions, only: %i[index create new edit show] do
    member do
      post 'generate_coupons'
      post 'approve'
    end
  end

  resources :coupons, only: [] do
    post 'inactivate', on: :member
  end
end
