class CriaPacientes < ActiveRecord::Migration
	def change
		create_table :pacientes do |t|
			t.string :nome, null: false
			t.date :nascimento
			t.string :identidade
			t.string :cpf
			t.text :endereco
			t.string :cartao_sus
			t.string :tipo_de_cancer
			t.timestamp	:obito
			t.text :observacao_obito
			t.timestamps
		end
	end
end