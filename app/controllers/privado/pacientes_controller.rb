class Privado::PacientesController < PrivadoController

	include Crud
	include TemImpressaoController

	def initialize
		@modelo = Paciente
		super
	end

	def menu_ativo
		:pacientes
	end

	def busca_lista
		pacientes = Paciente.includes(:servicos, :produtos, :escolaridade, :meios_contato, :anexos, :solicitacoes_servicos => [:servico, :profissional], :solicitacoes_produtos => {:produtos_solicitados => :produto})
		@pacientes = pacientes.vivo
		@pacientes_mortos = pacientes.morto.order('obito DESC')
	end

	def carrega_variaveis
		super
		@paciente.meios_contato.build if @paciente.meios_contato.empty?
		@paciente.anexos.build if @paciente.anexos.empty?
	end

	def registrar_obito
		@paciente = Paciente.find(params[:id])
		params[:form_partial_name] = 'form_registro_obito'
		respond_to do |f|
			f.html
			f.js{ render('crud/exibe_form') }
		end
	end
end
