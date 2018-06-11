class CriaSolicitacoesServicos < ActiveRecord::Migration
	def change
		create_table :solicitacoes_servicos do |t|
		  t.integer :paciente_id, null: false
		  t.integer :profissional_id, null: false
		  t.integer :servico_id, null: false
		  t.date :data, null: false
		  t.timestamps
		end
	end
end