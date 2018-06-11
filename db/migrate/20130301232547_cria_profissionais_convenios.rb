class CriaProfissionaisConvenios < ActiveRecord::Migration
	def change
		create_table :profissionais_convenios do |t|
		  t.integer :profissional_id, null: false
		  t.integer :convenio_id, null: false
		  t.timestamps
		end
	end
end