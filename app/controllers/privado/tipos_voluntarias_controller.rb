class Privado::TiposVoluntariasController < PrivadoController
	
	include Crud
	
	def initialize
		@modelo = TipoVoluntaria
		super
	end
	
	def menu_ativo
		:tipos_voluntarias
	end
end
