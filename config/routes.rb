Rails.application.routes.draw do

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root to: 'homes#top'
  end

  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    #resource :customers, only: [:show, :edit, :update]
    get '/customers' => 'customers#show', as: 'customers'
    get '/customers/information/edit' => 'customers#edit', as: 'edit_customers'
    patch '/customers/information' => 'customers#update', as: 'update'
    get 'check' => 'customers#check', as: 'check'
    patch 'withdraw' => 'customers#withdraw', as: 'withdraw'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
