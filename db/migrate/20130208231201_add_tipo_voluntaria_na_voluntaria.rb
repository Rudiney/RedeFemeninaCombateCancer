class AddTipoVoluntariaNaVoluntaria < ActiveRecord::Migration
	def change
		add_column :voluntarias, :tipo_voluntaria_id, :integer, null: false, default: 0
	end
end