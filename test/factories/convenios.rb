# encoding: UTF-8

FactoryGirl.define do
	factory :convenio do
		sequence(:nome) {|n| "Convênio #{n}" }
	end
end