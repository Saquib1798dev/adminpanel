Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  post 'users/forgot_password' => "users/passwords#forgot"
  post 'users/reset_password' => "users/passwords#reset"
  get 'users/help_portals' => "users/help_portals#index"
 # get 'users/verify_otp' => "users/passwords#verify_otp"
  match 'users/verify_otp' => 'users/passwords#verify_otp', via: [:get]

  namespace 'api' do
    namespace 'v1' do
      namespace :payments do
        post 'create_order'
        post 'verify_payment_state'
        get 'show_order'
      end
      resources :payments
      get 'social_media_users/google_auth2' => "social_media_users#google_oauth2", as: 'google_auth'
      resources :items
      resources :categories
      resources :user_details do 
        post 'generate_otp', on: :member
        post 'verify_otp', on: :member
        patch 'change_password', on: :member
      end
      resources :carts 
      delete '/line_items/:id' => 'line_items#destroy', as: 'remove_item'
      resources :line_items
      post 'line_items/:id/add' => 'line_items#add_quantity', as: 'line_item_add'
      post 'line_items/:id/reduce' => 'line_items#reduce_quantity', as: 'line_item_reduce'
      post 'favourites/add'
      post 'favourites/remove'
      get 'favourites/list'
      # get 'favourites/user_favourites'
    end
  end

  namespace :users do
    resources :addresses
  end
  root :to => redirect('/admin/login')

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
