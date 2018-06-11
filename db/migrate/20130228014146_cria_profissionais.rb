class CriaProfissionais < ActiveRecord::Migration
	def change
		create_table :profissionais, :force => true do |t|
			t.string :nome, null: false
			t.integer :servico_id, null: false
			t.string :municipio
			t.timestamps
		end
	end
end