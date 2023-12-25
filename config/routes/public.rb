scope module: :public do
  root 'pages#main'

  scope module: :pages do
    get 'about'
    get 'pricing'
    get 'cgu'
    get 'politique-confidentialite', as: :privacy_policy, action: :privacy_policy
    get 'mentions-legales', as: :company_details, action: :company_details
    get 'sitemaps'
  end

  resources :rgpd_cookies, only: :create
  resources :blog, as: :articles, controller: :articles, param: :slug, only: %i(index show)
  resources :faq, as: :question_and_answers, controller: :question_and_answers, only: :index
  resources :'qui-sommes-nous', as: :team_members, controller: :team_members, only: :index

  scope module: :invitations do
    resource :responses, only: :new
    resource :registrations, as: :invitation_registrations, only: %i(new create)
  end
end