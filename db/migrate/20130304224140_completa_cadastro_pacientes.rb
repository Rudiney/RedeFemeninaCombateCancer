class CompletaCadastroPacientes < ActiveRecord::Migration
	def change
		add_column :pacientes, :local_nascimento,        :text
		add_column :pacientes, :raca,                    :string
		add_column :pacientes, :escolaridade,            :string
		add_column :pacientes, :profissao,               :string
		add_column :pacientes, :endereco_profissional,   :text
		add_column :pacientes, :estado_civil,            :string
		add_column :pacientes, :nome_conjuge,            :string
		add_column :pacientes, :profissao_conjuge,       :string
		add_column :pacientes, :contato_conjuge,         :string
		add_column :pacientes, :tem_filhos,              :boolean
		add_column :pacientes, :quantidade_filhos,       :integer
		add_column :pacientes, :idade_filhos,            :string
		add_column :pacientes, :diagnostico,             :text
		add_column :pacientes, :tratamentos,             :text
		add_column :pacientes, :acompanhamento_medico,   :text
		add_column :pacientes, :medicamentos_utilizados, :text
		add_column :pacientes, :custo_manutencao_cancer, :text
		add_column :pacientes, :atividades,              :text
		add_column :pacientes, :horario_disponibilidade, :text
	end
end