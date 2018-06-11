class Convenio < ActiveRecord::Base
	attr_accessible :nome
	
	include TemDataDoCadastro
	
	validates :nome, presence: true	
	
	has_many :profissionais_convenios, :class_name => "ProfissionalConvenio", :foreign_key => "convenio_id"	
	has_many :profissionais, through: :profissionais_convenios, source: :profissional
	
end