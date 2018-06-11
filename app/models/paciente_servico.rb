class PacienteServico < ActiveRecord::Base
	self.table_name = :pacientes_servicos
	
	belongs_to :paciente, inverse_of: :pacientes_servicos
	belongs_to :servico
	
	validates :paciente, :servico, presence: true
end