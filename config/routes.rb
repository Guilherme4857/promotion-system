Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  resources :promotions, only: %i[index create new edit show] do
    post 'generate_coupons', on: :member 
  end

  resources :coupons, only: [] do
    post 'inactivate', on: :member
  end
end
