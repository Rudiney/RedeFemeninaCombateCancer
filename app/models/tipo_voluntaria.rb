class TipoVoluntaria < ActiveRecord::Base
	self.table_name = :tipos_voluntarias
	
	include TemDataDoCadastro
	
	attr_accessible :nome
	
	validates :nome, presence: true
	
	has_many :voluntarias
end
