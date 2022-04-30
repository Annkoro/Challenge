Rails.application.routes.draw do
  root to: "homes#top"

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # 顧客用
  # URL /users/sign_in ...
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # ユーザー側のURLにはpublicはつかない
  scope module: :public do
    resources :users, except: [:new, :create, :destroy] do
    end
  end
end
