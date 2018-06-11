class AddHoraSolicitacaoServico < ActiveRecord::Migration
	def change
		add_column(:solicitacoes_servicos, :hora, :string)
	end
end
