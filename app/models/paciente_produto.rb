class PacienteProduto < ActiveRecord::Base
	self.table_name = :pacientes_produtos
	
	belongs_to :paciente, inverse_of: :pacientes_produtos
	belongs_to :produto
	
	validates :paciente, :produto, presence: true
end