class AddObservacaoNivelEscolaridade < ActiveRecord::Migration
	def change
		add_column :niveis_escolaridade, :observacao, :text
	end
end