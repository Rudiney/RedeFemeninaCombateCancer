# encoding: UTF-8

class RelatorioCadastros
	
	AGRUPAMENTOS_POSSIVEIS = {
		'Mês'          => :mes
	}
	
	attr_accessor :data_inicial,:data_final,:agrupar_por


	def cadastros
		@cadastros ||= busca_cadastros
	end

	private

	def busca_cadastros
		@cadastros = ProdutoSolicitacaoProduto.entregue.order('solicitacoes_produtos.entregue_dia')

		private_methods.grep(/filtra_produtos_por/).each{|m| send(m) }

		@cadastros = @cadastros.group_by(&agrupar_por) if !agrupar_por.blank? && ProdutoSolicitacaoProduto.public_method_defined?(agrupar_por)

		return @cadastros
	end

	def filtra_produtos_por_data_inicial
		@cadastros = @cadastros.where('entregue_dia >= ?', data_inicial) unless data_inicial.blank?
	end
	
	def filtra_produtos_por_data_final
		@cadastros = @cadastros.where('entregue_dia <= ?', data_final) unless data_final.blank?
	end
end