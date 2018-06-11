class ProdutoSolicitacaoProduto < ActiveRecord::Base
	self.table_name = :produtos_solicitacoes_produtos
	
	attr_accessible :produto_id, :quantidade, :solicitacao_produto_id, :valido_ate
	
	validates :produto, :solicitacao_produto, :quantidade, presence: true
	validates :quantidade, numericality: {greater_than: 0}
	
	belongs_to :produto
	belongs_to :solicitacao_produto, inverse_of: :produtos_solicitados
	
	scope :vencida, where('produtos_solicitacoes_produtos.valido_ate <= CURRENT_DATE')
	
	scope :entregue, joins(:solicitacao_produto).where('solicitacoes_produtos.entregue_dia IS NOT NULL')
	
	delegate :mes, :to => :solicitacao_produto, :allow_nil => true
	delegate :paciente, :to => :solicitacao_produto, :allow_nil => true
	delegate :solicitado_dia, :to => :solicitacao_produto, :allow_nil => true
	delegate :entregue_dia, :to => :solicitacao_produto, :allow_nil => true
end