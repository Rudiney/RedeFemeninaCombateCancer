class Privado::ServicosController < PrivadoController
	
	include Crud
	
	def initialize
		@modelo = Servico
		super
	end
	
	def menu_ativo
		:servicos
	end
end
