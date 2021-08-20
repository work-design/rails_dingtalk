Rails.application.routes.draw do

  namespace :dingtalk, defaults: { business: 'dingtalk' } do
    namespace :admin, defaults: { namespace: 'admin' } do
      resources :apps
    end
  end

end
