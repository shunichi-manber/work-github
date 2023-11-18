Rails.application.routes.draw do

  namespace :public do
    get 'orders/new'
    get 'orders/index'
    get 'orders/show'
  end
  namespace :admin do
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
  end
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root to: 'homes#top'
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
  end

  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    #resource :customers, only: [:show, :edit, :update]
    get '/customers' => 'customers#show', as: 'customers'
    get '/customers/information/edit' => 'customers#edit', as: 'edit_customers'
    patch '/customers/information' => 'customers#update', as: 'update_customers'
    get '/customers/check' => 'customers#check', as: 'check'
    patch '/customers/withdraw' => 'customers#withdraw', as: 'withdraw'
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :update, :destroy, :create] do
      delete 'destroy_all', on: :collection
    end
    resources :orders, only: [:new, :index, :show, :create] do
      post 'info', on: :collection
      get 'complete', on: :collection
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
