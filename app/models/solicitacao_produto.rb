class SolicitacaoProduto < ActiveRecord::Base
	self.table_name = :solicitacoes_produtos

	attr_accessible :paciente_id, :solicitado_dia, :entregue_dia, :produtos_solicitados_attributes

	validates :paciente, :solicitado_dia, presence: true

	scope :entregue, where('entregue_dia IS NOT NULL')
	scope :nao_entregue, where(entregue_dia: nil)
	scope :vencida, lambda{
		ids = ProdutoSolicitacaoProduto.vencida.select('DISTINCT solicitacao_produto_id').to_sql
		where("solicitacoes_produtos.id IN (#{ids})")
	}

	belongs_to :paciente

	has_many :produtos_solicitados,
		class_name: "ProdutoSolicitacaoProduto",
		foreign_key: "solicitacao_produto_id",
		inverse_of: :solicitacao_produto,
		dependent: :destroy

	accepts_nested_attributes_for(:produtos_solicitados, allow_destroy: true)

	def entregue?
		!self.entregue_dia.blank?
	end

	def mes
		return self.entregue_dia.month if self.entregue_dia
	end

	def solicitado
		self.produtos_solicitados.map{|s| "#{s.quantidade} x #{s.produto.nome}"}.to_sentence
	end
end