class Privado::RelatorioAtividadeController < PrivadoController
	before_filter :menu_ativo
	
	def index
		@pacientes = Paciente.select('id, nome')
		@profissionais = Profissional.select('id, nome')
		@servicos = Servico.select('id, nome')
		@produtos = Produto.select('id, nome')
	end
	
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
		@menu_ativo = :relatorio_atividade
	end
	
	private
	
	def monta_relatorio
		@relatorio = RelatorioAtividade.new
		filtros = params[:filtros]
		@relatorio.data_inicial      = filtros[:data_inicial].to_date
		@relatorio.data_final        = filtros[:data_final].to_date
		@relatorio.agrupar_por       = filtros[:agrupar_por].to_sym
		@relatorio.pacientes_ids     = filtros[:pacientes_ids].reject(&:blank?)
		@relatorio.profissionais_ids = filtros[:profissionais_ids].reject(&:blank?)
		@relatorio.produtos_ids      = filtros[:produtos_ids].reject(&:blank?)
		@relatorio.servicos_ids      = filtros[:servicos_ids].reject(&:blank?)
	end
end