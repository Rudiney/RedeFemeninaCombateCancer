class Privado::NiveisEscolaridadeController < PrivadoController
	
	include Crud
	
	def initialize
		@modelo = NivelEscolaridade
		super
	end
	
	def menu_ativo
		:niveis_escolaridade
	end
end
