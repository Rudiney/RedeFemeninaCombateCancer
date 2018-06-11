# encoding: UTF-8

FactoryGirl.define do
	factory :solicitacao_servico do
		paciente
		profissional
		servico
		data          Date.today
		hora          {"#{(2..18).to_a.sample} horas"}
	end
end