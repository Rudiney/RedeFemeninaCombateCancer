class CriaPacienteServico < ActiveRecord::Migration
	def change
		create_table :pacientes_servicos do |t|
			t.integer :paciente_id, null: false
			t.integer :servico_id, null: false
			t.timestamps
		end
	end
end