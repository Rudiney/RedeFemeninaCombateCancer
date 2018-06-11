# encoding: UTF-8

FactoryGirl.define do
	factory :solicitacao_produto do
		paciente
		solicitado_dia Date.today
		
		trait :entregue do
			entregue_dia Date.today
		end
		
		trait :nao_entregue do
			entregue_dia nil
		end
	end
end