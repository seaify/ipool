Rails.application.routes.draw do
  get 'proxy_domain/index'

  resources :people

  get 'entries/sign_in'
  post 'entries/sign_in'

  get 'proxys' => 'proxy#proxys'
  post 'add_proxy' => 'proxy#add_proxy'
  post 'fetch_data' => 'proxy#fetch_data'
  get 'testme' => 'proxy#testme'
  get 'proxy_domains' => 'proxy#proxy_domains'
  get 'allow_all' => 'proxy#allow_all'
  get 'allow_selected_proxy' => 'proxy#allow_selected_proxy'
  get 'ban_selected_proxy' => 'proxy#ban_selected_proxy'
  get 'ban_all' => 'proxy#ban_all'
  get 'add_proxy_api' => 'proxy#add_proxy_api'

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
