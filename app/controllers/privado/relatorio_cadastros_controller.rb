class Privado::RelatorioCadastrosController < PrivadoController
	before_filter :menu_ativo
	
	def index; end
	
	def show
		monta_relatorio
		respond_to do |f|
			f.js
			f.html
		end
	end
	
	def imprimir
		monta_relatorio
		render('show', layout: 'impressao')
	end
		
	def menu_ativo
		@menu_ativo = :relatorio_cadastros
	end
	
	private
	
	def monta_relatorio
		filtros = params[:filtros]
		@pacientes = Paciente.where("created_at >= ? and created_at <= ?", filtros[:data_inicial].to_date, filtros[:data_final].to_date)
		# @relatorio = RelatorioCadastros.new
		# filtros = params[:filtros]
		# @relatorio.data_inicial      = filtros[:data_inicial].to_date
		# @relatorio.data_final        = filtros[:data_final].to_date
		# @relatorio.agrupar_por       = filtros[:agrupar_por].to_sym
		# @relatorio.pacientes_ids     = filtros[:pacientes_ids].reject(&:blank?)
		# @relatorio.profissionais_ids = filtros[:profissionais_ids].reject(&:blank?)
		# @relatorio.produtos_ids      = filtros[:produtos_ids].reject(&:blank?)
		# @relatorio.servicos_ids      = filtros[:servicos_ids].reject(&:blank?)
	end
end