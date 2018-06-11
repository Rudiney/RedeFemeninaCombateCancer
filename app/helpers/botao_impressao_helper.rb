module BotaoImpressaoHelper
	def botao_impressao(url)
		link_to_function(
			image_tag('botoes/printer2.png'), 
			"$('iframe#para_impressao').attr('src', '#{url}')", 
			style:'float: left; margin: 1px'
		)
	end
end