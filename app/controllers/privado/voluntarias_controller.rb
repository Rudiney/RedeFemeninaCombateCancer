class Privado::VoluntariasController < PrivadoController
	
	include Crud
	include TemImpressaoController
	
	def initialize
		@modelo = Voluntaria
		super
	end
	
	
	def carrega_variaveis
		@tipos_voluntarias = TipoVoluntaria.all
		@voluntaria.meios_contato.build if @voluntaria.meios_contato.empty?
		@voluntaria.anexos.build if @voluntaria.anexos.empty?
	end
	
	def busca_lista
		@voluntarias = Voluntaria.includes(:tipo_voluntaria, :meios_contato).order(:id)
	end
	
	def menu_ativo
		:voluntarias
	end
end
