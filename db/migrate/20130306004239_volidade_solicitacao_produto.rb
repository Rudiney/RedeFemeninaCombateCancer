class VolidadeSolicitacaoProduto < ActiveRecord::Migration
	def change
		add_column :produtos_solicitacoes_produtos, :valido_ate, :date
	end
end