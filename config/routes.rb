QAPI::Application.routes.draw do

  devise_for :users

  root 'static#index'

  namespace :admin do
    get '/', to: 'question_templates#index'

    resources :question_templates
  end

  scope 'api', format: 'json' do
    get '/',
        to: 'questions#random'

    resources :questions, path: 'question', only: [:show]
    get '/:latitude/:longitude',
        to: 'questions#show_lat_long',
        constraints: {
            latitude: /[0-9\.]+/,
            longitude: /[0-9\.]+/
        }

    get '/:latitude/:longitude/:count',
        to: 'questions#show_lat_long',
        constraints: {
            latitude: /[0-9\.]+/,
            longitude: /[0-9\.]+/,
            count: /[0-9\.]+/
        }
  end

  get 'places/:latitude/:longitude', to: 'places#geocode', constraints: {latitude: /[0-9\.]+/, longitude: /[0-9\.]+/}

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
