# encoding: UTF-8

FactoryGirl.define do
	factory :profissional do
		nome {generate(:nome_completo)}
		servico
	end
end