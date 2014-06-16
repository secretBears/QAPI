QAPI::Application.routes.draw do
  lat_lng_validator = Regexp.new '-?[0-9\.]+'

  devise_for :users

  root 'static#index'

  resources :question_templates, except: [:show, :edit]
  get 'question_templates/:id', to: 'question_templates#edit'

  resources :reports, except: [:new, :create, :edit, :update]

  get 'docs', to: 'static#docs'

  resources :users do
    member do
      put 'toggle_admin'
    end
  end

  scope '/cache' do
    get '/', to: 'cache#index', as: 'cache'

    scope '/clear' do
      scope '/all' do
        get '/',          to: 'cache#clear_all',           as: 'cache_clear_all'
        get '/places',    to: 'cache#clear_all_places',    as: 'cache_clear_all_places'
        get '/questions', to: 'cache#clear_all_questions', as: 'cache_clear_all_questions'
      end

      get '/question-from-template/:template_id',
          to: 'cache#clear_questions_from_template',
          as: 'cache_clear_question_from_template'
    end
  end

  scope 'api', format: 'json' do
    resources :questions, path: 'question', only: [:show]

    get '/:lat/:lng/(:count)',
        to: 'questions#index_lat_lng',
        constraints: {
          lat: lat_lng_validator,
          lng: lat_lng_validator,
          count: /[0-9\.]+/
        }

    get '/bypass/:template_id/:place_id', to: 'questions#show_from_template_and_place'

    get 'test/:place_id', to: 'questions#test_query'

    get 'report/:question_id' => 'reports#new', as: 'new_api_report', format: :html
    post 'reports' => 'reports#create', as: 'api_reports', format: :html
  end
end
