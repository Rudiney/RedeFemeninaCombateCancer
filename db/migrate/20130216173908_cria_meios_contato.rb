class CriaMeiosContato < ActiveRecord::Migration
	def change
		create_table :meios_contatos do |t|
			t.string :dono_type, null: false
			t.integer :dono_id,  null: false
			t.string :tipo,      null: false
			t.string :valor,     null: false
			t.timestamps
		end
	end
end