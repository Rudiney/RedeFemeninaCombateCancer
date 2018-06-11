FactoryGirl.define do
	factory :paciente do
		nome {generate(:nome_completo)}
		estado_civil :casado
		escolaridade
		
		trait :vivo do
			obito nil
		end
		
		trait :morto do
			obito {Time.new(rand(1990..2010), rand(1..12), rand(1..28), rand(20), rand(59))}
		end
	end
end