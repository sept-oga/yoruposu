Rails.application.routes.draw do
  # devise_for :admins（コメントアウト）
  devise_for :users

  # 管理者の新規登録はスキップ
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  get 'about', to: 'homes#about', as: 'about'
  resources :users, only: [:show, :edit, :update, :destroy]
  resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resources :comments, only: [:create, :destroy]
  end

  # ゲストログイン機能
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
end
