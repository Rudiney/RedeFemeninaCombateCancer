class SolicitacaoServico < ActiveRecord::Base
	self.table_name = :solicitacoes_servicos

	attr_accessible :paciente_id, :profissional_id, :data, :servico_id, :hora

	validates :paciente, :profissional, :servico, :data, presence: true

	belongs_to :paciente
	belongs_to :profissional
	belongs_to :servico

	def mes
		return self.data.month if self.data
	end
end