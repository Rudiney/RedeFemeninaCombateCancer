FactoryGirl.define do
	factory :voluntaria do
		nome {generate(:nome_completo)}
		nascimento Date.new(1989, 11, 06)
		estado_civil :casado
		escolaridade
		tipo_voluntaria
		atuante { [true,false].sample }
	end
end