class CreateVoluntarias < ActiveRecord::Migration
	def change
		create_table :voluntarias do |t|
			t.string    :nome, null: false
			t.string    :cpf
			t.string    :identidade
			t.date	   :nascimento, null: false
			t.string    :local_de_nascimento
			t.string    :estado_civil, null: false
			t.string    :nome_do_esposo
			t.string    :profissao
			t.string    :escolaridade, null: false
			t.string    :endereco
			t.text      :horario_para_contato
			t.boolean   :atuante, null: false
			t.timestamp :ativada_em
			t.timestamps
		end
	end
end
