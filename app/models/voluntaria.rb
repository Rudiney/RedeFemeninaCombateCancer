class Voluntaria < ActiveRecord::Base
	
	include TemMeiosContato
	include TemAnexos
	include TemDataDoCadastro
	
	attr_accessible :nome, :cpf, :identidade, :nascimento, :local_de_nascimento,
	:estado_civil, :nome_do_esposo, :profissao, :escolaridade_id, :endereco, :atuante,
	:horario_para_contato, :tipo_voluntaria, :tipo_voluntaria_id, :areas_interesse, 
	:sugestoes
	
	classy_enum_attr :estado_civil

	before_save :nao_salva_atuante_nulo
	
	validates :nome, :nascimento, :estado_civil, :escolaridade,  presence: true
	validates :tipo_voluntaria, :escolaridade, presence: true, associated: true
	
	belongs_to :tipo_voluntaria
	belongs_to :escolaridade, class_name: 'NivelEscolaridade'
	
	scope :atuante, where(atuante: true)
	scope :nao_atuante, where(atuante: false)
	
	def atuante=(atuante)
		self.ativada_em = Time.now if !self.atuante && atuante
		self.ativada_em = nil if atuante === false
		super
	end

	def idade
		return unless self.nascimento
		return Date.today.year - self.nascimento.year - ((Date.today.month > self.nascimento.month || (Date.today.month == self.nascimento.month && Date.today.day >= self.nascimento.day)) ? 0 : 1)
	end

	private
	
	def nao_salva_atuante_nulo		
		self.atuante = false if self.atuante.nil?
		return true
	end
end
