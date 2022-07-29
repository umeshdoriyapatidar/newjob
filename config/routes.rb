# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
 
  get 'job_applications/index'
  get 'job_applications/apply'
  get 'job_applications/user_application'
  get 'job_applications/accept'
  get 'job_applications/rejected'
  get 'verifyotp', to: 'job_applications#verifyotp'
  get 'job_applications/verify'
  get 'job_applications/destroy'
  get  'home/show'
  # delete 'jobs/:id' ,to: 'jobs#destroy'
  resources :jobs 
  # devise_for :users 
  
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
 end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
