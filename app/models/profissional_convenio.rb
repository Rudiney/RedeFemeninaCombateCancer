class ProfissionalConvenio < ActiveRecord::Base
	self.table_name = :profissionais_convenios
	
	belongs_to :profissional, inverse_of: :profissionais_convenios
	belongs_to :convenio
	
	validates :convenio, :profissional, presence: true
end