FactoryGirl.define do
	factory :meio_contato do
		dono_type 'Voluntaria'
		dono_id { FactoryGirl.create(:voluntaria).id }
		tipo {['Tel. Residencial', 'Tel. Comercial', 'Celular', 'E-mail', 'MSN', 'Skype', 'Facebook', 'Twitter'].sample}
		valor 'bablablablablabla'
	end
end