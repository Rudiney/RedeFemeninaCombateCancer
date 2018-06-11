class CriaAnexos < ActiveRecord::Migration
	def change
		create_table :anexos do |t|
			t.integer :dono_id
			t.string  :dono_type
			t.string :nome
			t.attachment :arquivo
			t.timestamps
		end
	end
end