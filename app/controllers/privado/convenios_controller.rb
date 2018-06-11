class Privado::ConveniosController < PrivadoController
	
	include Crud
	
	def initialize
		@modelo = Convenio
		super
	end
	
	def menu_ativo
		:convenios
	end
end
