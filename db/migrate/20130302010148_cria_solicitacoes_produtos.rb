class CriaSolicitacoesProdutos < ActiveRecord::Migration
	def change
		create_table :solicitacoes_produtos do |t|
		  t.integer :paciente_id, null: false
		  t.date :solicitado_dia, null: false
		  t.date :entregue_dia
		  t.timestamps
		end
	end
end