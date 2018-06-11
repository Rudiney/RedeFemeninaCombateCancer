# encoding: UTF-8

module TemImpressaoController
	def impressao
		busca_registro
		render('impressao', layout: 'impressao')
	end
end