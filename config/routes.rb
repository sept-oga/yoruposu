Rails.application.routes.draw do

  # 管理者の新規登録はスキップ
  devise_for :admin, skip: [:registrations], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:show, :destroy]
    resources :posts, only: [:index, :show, :destroy] do
      resources :comments, only: [:destroy]
    end
    resources :groups, only: [:index, :show, :update, :destroy] do
      # ↓updateかも？
      resource :group_members, only: [:create, :destroy]
    end
    get '/search', to: 'searches#search'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope module: :public do
    root to: 'homes#top'
    devise_for :users
    get '/search', to: 'searches#search'
    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
    end
    resources :users, only: [:show, :edit, :update, :destroy]
    resources :groups, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
      # ↓updateかも？
      resource :group_members, only: [:create, :destroy]
    end
  end

  # ゲストログイン機能
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
end
