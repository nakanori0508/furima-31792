Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
    # itemsコントローラーが持っているテーブル情報を持ったままordersコントローラーに移動できる（これがネスト構造）
    # 親情報が持ってる情報は、子要素も持つことができる
  resources :items do
    resources :orders, only: [:index,:create]
  end
end
