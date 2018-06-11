# encoding: UTF-8

FactoryGirl.define do
	factory :produto do
		sequence(:nome) {|n| "Produto #{n}" }
	end
end