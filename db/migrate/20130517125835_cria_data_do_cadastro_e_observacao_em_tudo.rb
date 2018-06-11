class CriaDataDoCadastroEObservacaoEmTudo < ActiveRecord::Migration
	def change
		[:voluntarias, :pacientes, :profissionais, :tipos_voluntarias, 
		:servicos, :produtos, :convenios, :users].each do |table|
			
			add_column(table, :data_do_cadastro, :date)
			add_column(table, :observacao, :text)
		end
	end
end