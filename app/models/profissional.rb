class Profissional < ActiveRecord::Base

	include TemMeiosContato
	include TemAnexos
	include TemDataDoCadastro

	attr_accessible :nome, :municipio, :servico_id, :convenio_ids

	validates :nome, :servico, presence: true

	belongs_to :servico

	has_many :profissionais_convenios, :class_name => "ProfissionalConvenio", :foreign_key => "profissional_id", inverse_of: :profissional
	has_many :convenios, through: :profissionais_convenios, source: :convenio

	has_many :solicitacoes_servicos, :class_name => "SolicitacaoServico"
end