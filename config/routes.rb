RedeFeminina::Application.routes.draw do

  devise_for :users

	root :to => 'privado/pacientes#index'

	scope :module => 'privado' do

		resources :tipos_voluntarias, :servicos, :produtos, :profissionais,
			:convenios, :solicitacoes_produtos, :solicitacoes_servicos, :users, :niveis_escolaridade

		resources :voluntarias do
			member do
				get 'impressao'
			end
		end
		resources :pacientes do
			member do
				get 'impressao'
				get 'registrar_obito'
			end
		end

		get 'aniversariantes' => 'aniversariantes#index'
		
		get 'relatorio_atividade' => 'relatorio_atividade#index'
		post 'relatorio_atividade' => 'relatorio_atividade#show'
		get 'relatorio_atividade/imprimir' => 'relatorio_atividade#imprimir', as: :imprimir_relatorio_atividade
		
		get 'relatorio_cadastros' => 'relatorio_cadastros#index'
		post 'relatorio_cadastros' => 'relatorio_cadastros#show'
		get 'relatorio_cadastros/imprimir' => 'relatorio_cadastros#imprimir', as: :imprimir_relatorio_cadastros

	end
end
