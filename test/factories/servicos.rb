# encoding: UTF-8

FactoryGirl.define do
	factory :servico do
		sequence(:nome) {|n| "Serviço #{n}" }
	end
end