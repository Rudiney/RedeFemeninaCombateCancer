FactoryGirl.define do
	factory :produto_solicitacao_produto do
		solicitacao_produto	{ 
			attrs = {
				entregue_dia: entregue_dia,
			}
			
			attrs.merge!(paciente: paciente) if paciente
			
			FactoryGirl.create(:solicitacao_produto, attrs)
		}
		produto
		quantidade 1
		
		ignore do
			entregue_dia Date.today
			paciente nil
		end
		
		trait :nao_entregue do
			solicitacao_produto{ FactoryGirl.create(:solicitacao_produto, :nao_entregue) }
		end
	end
end