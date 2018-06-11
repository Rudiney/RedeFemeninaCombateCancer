class Privado::AniversariantesController < PrivadoController
	def index
		query_de_hoje = "extract(day from nascimento) = #{Date.today.day} AND extract(month from nascimento) = #{Date.today.month}"
		@aniversariantes_de_hoje = []
		@aniversariantes_de_hoje += Voluntaria.where(query_de_hoje).all
		@aniversariantes_de_hoje += Paciente.vivo.where(query_de_hoje).all
		
		cookies[:aniversariantes] = @aniversariantes_de_hoje.size
		
		query_proximos = "extract(doy from nascimento) > #{Date.today.yday} AND extract(doy from nascimento) <= #{(Date.today+11.days).yday}"
		@proximos_aniversariantes = []
		@proximos_aniversariantes += Voluntaria.where(query_proximos).all
		@proximos_aniversariantes += Paciente.vivo.where(query_proximos).all
		
		@proximos_aniversariantes.sort!{|a,b| a.nascimento.yday <=> b.nascimento.yday }
		
		@todos = @aniversariantes_de_hoje + @proximos_aniversariantes
	end
	
	def menu_ativo
		:aniversariantes
	end
end