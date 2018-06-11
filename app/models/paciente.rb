class Paciente < ActiveRecord::Base
	
	include TemMeiosContato
	include TemAnexos
	include TemDataDoCadastro
	
	attr_accessible :nome, :identidade, :cpf, :nascimento, :endereco, :cartao_sus, 
	:tipo_de_cancer, :obito, :observacao_obito, :servico_ids, :produto_ids,
	:local_nascimento, :raca, :escolaridade_id, :profissao, :endereco_profissional, :estado_civil, 
	:nome_conjuge, :profissao_conjuge, :contato_conjuge, :tem_filhos, :quantidade_filhos, 
	:idade_filhos, :diagnostico, :tratamentos, :acompanhamento_medico, :medicamentos_utilizados, 
	:custo_manutencao_cancer, :atividades, :horario_disponibilidade
	
	classy_enum_attr :estado_civil
	
	validates :nome, presence: true
	
	scope :vivo, where(obito: nil)
	scope :morto, where('pacientes.obito IS NOT NULL')
	
	has_many :pacientes_servicos, class_name: 'PacienteServico', inverse_of: :paciente
	has_many :servicos, through: :pacientes_servicos, source: :servico
	
	has_many :pacientes_produtos, class_name: 'PacienteProduto', inverse_of: :paciente
	has_many :produtos, through: :pacientes_produtos, source: :produto
	
	has_many :solicitacoes_produtos, class_name: 'SolicitacaoProduto'
	has_many :solicitacoes_servicos, class_name: 'SolicitacaoServico'
	
	belongs_to :escolaridade, class_name: 'NivelEscolaridade'
	validates :escolaridade, presence: true, associated: true
		
	def vivo?
		self.obito.blank?
	end
	
	def morto?
		self.obito?
	end
	
	def idade
		return unless self.nascimento
		return Date.today.year - self.nascimento.year - ((Date.today.month > self.nascimento.month || (Date.today.month == self.nascimento.month && Date.today.day >= self.nascimento.day)) ? 0 : 1)
	end
end