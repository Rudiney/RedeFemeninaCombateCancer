class Privado::SolicitacoesProdutosController < PrivadoController
	
	include Crud
	
	def initialize
		@modelo = SolicitacaoProduto
		super
		@nome_singular = :solicitacao_produto
		@nome_plural = :solicitacoes_produtos
	end
	
	def menu_ativo
		:solicitacoes_produtos
	end
	
	def busca_lista
		super
		@solicitacoes_produtos = @solicitacoes_produtos.includes(:paciente)
		@vencidas = @solicitacoes_produtos.vencida.reorder('entregue_dia ASC')
		@solicitacoes_produtos = @solicitacoes_produtos.where("solicitacoes_produtos.id NOT IN (?)",@vencidas) if @vencidas.any?
		@nao_entregues = @solicitacoes_produtos.nao_entregue.reorder('solicitado_dia ASC')
		@entregues = @solicitacoes_produtos.entregue.reorder('entregue_dia ASC')
	end
	
	def carrega_variaveis
		@solicitacao_produto.produtos_solicitados.build(quantidade: 1) if @solicitacao_produto.produtos_solicitados.empty?
	end
end
