class Privado::ProfissionaisController < PrivadoController

	include Crud

	def initialize
		@modelo = Profissional
		super
	end

	def menu_ativo
		:profissionais
	end

	def carrega_variaveis
		@profissional.meios_contato.build if @profissional.meios_contato.empty?
		@profissional.anexos.build if @profissional.anexos.empty?
	end
end
