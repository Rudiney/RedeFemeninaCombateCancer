# encoding: UTF-8

FactoryGirl.define do
	factory :nivel_escolaridade, aliases: [:escolaridade] do
		sequence(:nome) {|n| "Nível de escolaridade #{n}" }
	end
end