Rails.application.routes.draw do

  root 'groups#index'

  resources :groups do
    resources :orders
  end

  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'

  namespace :admin do
    root to: 'dashboard#show'
    resources :users
    resources :shops do
      resources :drinks
    end
    resources :groups
  end

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

# == Route Map
#
#                Prefix Verb   URI Pattern                                     Controller#Action
#                  root GET    /                                               groups#index
#          group_orders GET    /groups/:group_id/orders(.:format)              orders#index
#                       POST   /groups/:group_id/orders(.:format)              orders#create
#       new_group_order GET    /groups/:group_id/orders/new(.:format)          orders#new
#      edit_group_order GET    /groups/:group_id/orders/:id/edit(.:format)     orders#edit
#           group_order GET    /groups/:group_id/orders/:id(.:format)          orders#show
#                       PATCH  /groups/:group_id/orders/:id(.:format)          orders#update
#                       PUT    /groups/:group_id/orders/:id(.:format)          orders#update
#                       DELETE /groups/:group_id/orders/:id(.:format)          orders#destroy
#                groups GET    /groups(.:format)                               groups#index
#                       POST   /groups(.:format)                               groups#create
#             new_group GET    /groups/new(.:format)                           groups#new
#            edit_group GET    /groups/:id/edit(.:format)                      groups#edit
#                 group GET    /groups/:id(.:format)                           groups#show
#                       PATCH  /groups/:id(.:format)                           groups#update
#                       PUT    /groups/:id(.:format)                           groups#update
#                       DELETE /groups/:id(.:format)                           groups#destroy
#                 users GET    /users(.:format)                                users#index
#                       POST   /users(.:format)                                users#create
#              new_user GET    /users/new(.:format)                            users#new
#             edit_user GET    /users/:id/edit(.:format)                       users#edit
#                  user GET    /users/:id(.:format)                            users#show
#                       PATCH  /users/:id(.:format)                            users#update
#                       PUT    /users/:id(.:format)                            users#update
#                       DELETE /users/:id(.:format)                            users#destroy
#              sessions POST   /sessions(.:format)                             sessions#create
#           new_session GET    /sessions/new(.:format)                         sessions#new
#               session DELETE /sessions/:id(.:format)                         sessions#destroy
#                signin GET    /signin(.:format)                               sessions#new
#               signout DELETE /signout(.:format)                              sessions#destroy
#            admin_root GET    /admin(.:format)                                admin/dashboard#show
#           admin_users GET    /admin/users(.:format)                          admin/users#index
#                       POST   /admin/users(.:format)                          admin/users#create
#        new_admin_user GET    /admin/users/new(.:format)                      admin/users#new
#       edit_admin_user GET    /admin/users/:id/edit(.:format)                 admin/users#edit
#            admin_user GET    /admin/users/:id(.:format)                      admin/users#show
#                       PATCH  /admin/users/:id(.:format)                      admin/users#update
#                       PUT    /admin/users/:id(.:format)                      admin/users#update
#                       DELETE /admin/users/:id(.:format)                      admin/users#destroy
#     admin_shop_drinks GET    /admin/shops/:shop_id/drinks(.:format)          admin/drinks#index
#                       POST   /admin/shops/:shop_id/drinks(.:format)          admin/drinks#create
#  new_admin_shop_drink GET    /admin/shops/:shop_id/drinks/new(.:format)      admin/drinks#new
# edit_admin_shop_drink GET    /admin/shops/:shop_id/drinks/:id/edit(.:format) admin/drinks#edit
#      admin_shop_drink GET    /admin/shops/:shop_id/drinks/:id(.:format)      admin/drinks#show
#                       PATCH  /admin/shops/:shop_id/drinks/:id(.:format)      admin/drinks#update
#                       PUT    /admin/shops/:shop_id/drinks/:id(.:format)      admin/drinks#update
#                       DELETE /admin/shops/:shop_id/drinks/:id(.:format)      admin/drinks#destroy
#           admin_shops GET    /admin/shops(.:format)                          admin/shops#index
#                       POST   /admin/shops(.:format)                          admin/shops#create
#        new_admin_shop GET    /admin/shops/new(.:format)                      admin/shops#new
#       edit_admin_shop GET    /admin/shops/:id/edit(.:format)                 admin/shops#edit
#            admin_shop GET    /admin/shops/:id(.:format)                      admin/shops#show
#                       PATCH  /admin/shops/:id(.:format)                      admin/shops#update
#                       PUT    /admin/shops/:id(.:format)                      admin/shops#update
#                       DELETE /admin/shops/:id(.:format)                      admin/shops#destroy
#          admin_groups GET    /admin/groups(.:format)                         admin/groups#index
#                       POST   /admin/groups(.:format)                         admin/groups#create
#       new_admin_group GET    /admin/groups/new(.:format)                     admin/groups#new
#      edit_admin_group GET    /admin/groups/:id/edit(.:format)                admin/groups#edit
#           admin_group GET    /admin/groups/:id(.:format)                     admin/groups#show
#                       PATCH  /admin/groups/:id(.:format)                     admin/groups#update
#                       PUT    /admin/groups/:id(.:format)                     admin/groups#update
#                       DELETE /admin/groups/:id(.:format)                     admin/groups#destroy
#
