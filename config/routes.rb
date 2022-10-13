Rails.application.routes.draw do
	scope '/api' do
		# mount_devise_token_auth_for 'User', at: '/auth'
		mount_devise_token_auth_for 'User', at: 'auth', controllers: {
			registrations:	'custom/registrations'
		}
		# resources :groups, except: [:new, :edit]

		resources :access_levels
		resources :calls
		resources :cards
		resources :countries
		resources :diagnostics
		resources :doctor_types

		resources :users do 
			resources :practices
		end

		resources :doctor_staffs
		resources :patients
		resources :tasks
		resources :facilities
		resources :doctor_schedules

		resources :requests
		resources :states
		resources :allergies
		resources :allergy_searches
		resources :appointment_patients
		resources :appointment_types
		resources :chit_chats
		resources :ctp_codes
		resources :encounters

		resources :health_exam_dates
		resources :medical_histories
		resources :medication_searches
		resources :medication_years
		resources :medications
		resources :patient_registrations
		resources :pediatric_forms

		resources :reactions
		resources :reactions
		resources :requests
		resources :short_hands
		resources :soaps
		resources :social_adults
		resources :supper_bills
		resources :sur_years
		resources :transactions
		resources :vitals

		get '/profile' => 'profile#show'
		put '/profile' => 'profile#update'

		get '/practice' => 'practices#show'
		put '/practice' => 'practices#update'

		scope '/thirdparty' do 
			get 'view-fax-inbox'	=> 'third_party#index_fax_inbox'
			post 'read-fax-inbox'	=> 'third_party#read_fax_inbox'
			delete 'fax-inbox/:id'	=> 'third_party#delete_fax_inbox'

			get 'view-fax-sent'		=> 'third_party#index_fax_sent'
			delete 'fax-sent/:id'	=> 'third_party#delete_fax_sent'
			post 'send-fax-sent'	=> 'third_party#send_fax_sent'
			post 'resend-fax-sent'	=> 'third_party#resend_fax_sent'

			get 'view-mail-inbox/:type'	=> 'third_party#index_mail_inbox'
			post 'read-mail-inbox'		=> 'third_party#read_mail_inbox'
			delete 'mail-inbox/:id'		=> 'third_party#delete_mail_inbox'

			get 'view-mail-sent/:type'	=> 'third_party#index_mail_sent'
			delete 'mail-sent/:id'		=> 'third_party#delete_mail_sent'
			post 'send-mail-sent'		=> 'third_party#send_mail_sent'
			post 'resend-mail-sent'		=> 'third_party#resend_mail_sent'			
		end
	end

	scope '/download' do
		get '/fax/:type/:id' => 'third_party#download_fax'
		get '/mail/:type/:id' => 'third_party#download_attachment'
	end

	# The priority is based upon order of creation: first created -> highest priority.
	# See how all your routes lay out with "rake routes".

	# You can have the root of your site routed with "root"
	root to: 'application#angular'

	# Example of regular route:
	#	 get 'products/:id' => 'catalog#view'

	# Example of named route that can be invoked with purchase_url(id: product.id)
	#	 get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

	# Example resource route (maps HTTP verbs to controller actions automatically):
	#	 resources :products

	# Example resource route with options:
	#	 resources :products do
	#		 member do
	#			 get 'short'
	#			 post 'toggle'
	#		 end
	#
	#		 collection do
	#			 get 'sold'
	#		 end
	#	 end

	# Example resource route with sub-resources:
	#	 resources :products do
	#		 resources :comments, :sales
	#		 resource :seller
	#	 end

	# Example resource route with more complex sub-resources:
	#	 resources :products do
	#		 resources :comments
	#		 resources :sales do
	#			 get 'recent', on: :collection
	#		 end
	#	 end

	# Example resource route with concerns:
	#	 concern :toggleable do
	#		 post 'toggle'
	#	 end
	#	 resources :posts, concerns: :toggleable
	#	 resources :photos, concerns: :toggleable

	# Example resource route within a namespace:
	#	 namespace :admin do
	#		 # Directs /admin/products/* to Admin::ProductsController
	#		 # (app/controllers/admin/products_controller.rb)
	#		 resources :products
	#	 end
end
