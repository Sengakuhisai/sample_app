Rails.application.routes.draw do
  get 'foo/bar'

  get 'foo/bazz'

  get 'static_pages/home'

  get 'static_pages/help'

  root 'static_pages#home'
end
