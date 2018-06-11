class Privado::SolicitacoesServicosController < PrivadoController
	
	include Crud
	
	def initialize
		@modelo = SolicitacaoServico
		super
	end
	
	def menu_ativo
		:solicitacoes_servicos
	end
	
	def busca_lista
		super
		@passadas = @solicitacoes_servicos.reorder('data').where('data < ?', Date.today)
		@futuras = @solicitacoes_servicos.reorder('data').where('data >= ?', Date.today)
	end
end
