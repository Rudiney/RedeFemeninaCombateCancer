FactoryGirl.define do
	factory :relatorio_atividade do
		data_inicial nil
		data_final nil
		pacientes_ids nil
		profissionais_ids nil
		servicos_ids nil
		agrupar_por nil
	end
end