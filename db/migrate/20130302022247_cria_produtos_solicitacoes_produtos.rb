class CriaProdutosSolicitacoesProdutos < ActiveRecord::Migration
	def change
		create_table :produtos_solicitacoes_produtos do |t|
			t.integer :produto_id, null: false
			t.integer :solicitacao_produto_id, null: false
			t.integer :quantidade, null: false
			t.timestamps
		end
	end
end