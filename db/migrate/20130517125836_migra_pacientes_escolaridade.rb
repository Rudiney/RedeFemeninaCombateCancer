# encoding: UTF-8

class MigraPacientesEscolaridade < ActiveRecord::Migration
  def up
	      NivelEscolaridade.create!(nome: 'Ensino Fundamental Incompleto')
	efc                = NivelEscolaridade.create!(nome: 'Ensino Fundamental Completo')
	      NivelEscolaridade.create!(nome: 'Ensino Médio Incompleto')
	emc                = NivelEscolaridade.create!(nome: 'Ensino Médio Completo')
	      NivelEscolaridade.create!(nome: 'Ensino Superior Incompleto')
	esc                = NivelEscolaridade.create!(nome: 'Ensino Superior Completo')
	
	add_column(:pacientes, :escolaridade_id, :integer)
	add_column(:voluntarias, :escolaridade_id, :integer)
	
	(Paciente.all + Voluntaria.all).each do |p|
		
		p.escolaridade_id = case p.attributes['escolaridade'].to_sym
		when :ensino_medio
			emc.id
		when :ensino_fundamental
			efc.id
		when :ensino_superior
			esc.id
		else
			raise "#{p.class.name} #{p.id} sem escolaridade"
		end
		
		p.save!
	end
	
	remove_column(:pacientes, :escolaridade)
	remove_column(:voluntarias, :escolaridade)
	
  end
  
  def down
	  remove_column(:pacientes, :escolaridade_id)
	  remove_column(:voluntarias, :escolaridade_id)
	  
	  add_column(:pacientes, :escolaridade, :string)
	  add_column(:voluntarias, :escolaridade, :string)
  end
end
