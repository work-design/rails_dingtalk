Rails.application.routes.draw do

  namespace :dingtalk, defaults: { business: 'dingtalk' } do
    namespace :admin, defaults: { namespace: 'admin' } do
      resources :apps
    end

    controller :home do
      get :index
    end
    resources :apps do
      collection do
        get :info
      end
    end
  end

end
