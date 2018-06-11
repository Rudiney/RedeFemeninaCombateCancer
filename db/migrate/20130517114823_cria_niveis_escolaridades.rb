class CriaNiveisEscolaridades < ActiveRecord::Migration
	def change
		create_table :niveis_escolaridade do |t|
		  t.string :nome, null: false
		  t.date :data_do_cadastro
		  t.timestamps
		end
	end
end