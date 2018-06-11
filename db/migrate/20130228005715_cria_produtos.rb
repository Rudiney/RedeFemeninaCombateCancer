# encoding: UTF-8

class CriaProdutos < ActiveRecord::Migration
	def change
		create_table :produtos do |t|
			t.string :nome, null: false
			t.timestamps
		end

		create_table :pacientes_produtos do |t|
			t.integer :paciente_id, null: false
			t.integer :produto_id,  null: false
			t.timestamps
		end
		
		Produto.create(['Peruca','Prótese Mamária','Medicamento','Vale Transporte','Higienodietético'].map{|n| {nome: n} })
	end
end