class Servico < ActiveRecord::Base
	attr_accessible :nome
	
	include TemDataDoCadastro
	
	validates :nome, presence: true
	
	has_many :pacientes_servicos, class_name: 'PacienteServico'
	has_many :pacientes, through: :pacientes_servicos, source: :paciente
	
	has_many :profissionais
	
	has_many :solicitacoes_servicos, :class_name => "SolicitacaoServico"
	
end