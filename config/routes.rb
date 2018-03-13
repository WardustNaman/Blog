
Rails.application.routes.draw do
		get 'categories/check_name_present'
		get 'articles/check_name_present'

  devise_for :users
	resources :reviews
	resources :categories
	resources :articles
	get 'say/goodbye'
	get 'say/hello'
	root 'say#hello'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end