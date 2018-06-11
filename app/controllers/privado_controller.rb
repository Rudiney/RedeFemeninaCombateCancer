class PrivadoController < ApplicationController
	
	layout "privado"
	
	before_filter :authenticate_user!
	
	before_filter :seta_menu_ativo
	
	def js_redirect_to(url)
		url = url.is_a?(Hash) ? url_for(url) : url
		render(:js => "window.location = '#{url}';")
	end
	
	private
	
	def seta_menu_ativo
		@menu_ativo = menu_ativo
	end
	
	def menu_ativo
		''
	end
end