class NivelEscolaridade < ActiveRecord::Base
	
	include TemDataDoCadastro
	
	attr_accessible :nome
	
	validates :nome, presence: true, length: {maximum: 255}
	
	has_many :pacientes, foreign_key: 'escolaridade_id'
	has_many :voluntarias, foreign_key: 'escolaridade_id'
	
end