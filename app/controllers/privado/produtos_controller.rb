class Privado::ProdutosController < PrivadoController
	
	include Crud
	
	def initialize
		@modelo = Produto
		super
	end
	
	def menu_ativo
		:produtos
	end
end
