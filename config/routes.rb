FiatPublication::Engine.routes.draw do
  resources :pages
  resources :articles
  resources :content_blocks
  resources :authors
  resources :messages
  resources :comments
  resources :attachments
  resources :content_labels
  resources :content_label_assignments
end
