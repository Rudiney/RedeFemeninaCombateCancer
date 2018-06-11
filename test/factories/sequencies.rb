# encoding: UTF-8

nomes = %w{ Maria José Antônio João Francisco Ana Luiz Paulo Carlos Manoel Pedro Francisca Marcos Raimundo Sebastião Antônia Marcelo Jorge Márcia Geraldo Adriana Sandra Luis Fernando Fabio Roberto Márcio Edson André Sérgio Josefa Patrícia Daniel Rodrigo Rafael Joaquim Vera Ricardo Eduardo Terezinha Sônia Alexandre }
sobrenomes = %w{ Abarca Albernaz Albuquerque Alcântara Almeida Andrade Azevedos Avelar Arantes Araújo Baldaya Barros Bettencourt Brito do Rio Bruges Brum Cabral Cacena Coutinho Correa Diniz Drummond Damasceno Dias Enes Esteves Estrada Fagundes Falcão Faria Figueira Freitas Freire Furtado Godinho Guterres Henriques Hipólito Leão Leitão Leite Leme Lemos Lima Linhares Lobato Lobo Lopes Lousada Marques Martins Matos Marinho Messias Mesquita Mesquita Pimentel Miranda Moita Moniz Monjardino Moura Muniz Mercado Neto Neves Pamplona Parreira Paiva Paranhos Paredes Passos Paz Pedroso Peixoto Pereira Queiroga Queirós Quintanilha Ramalho Ramires Ramos Sacadura Sales Salgado Salgueiro Sampaio Sarmento Seabra Séguier Seixas Sequeira Serpa Teixeira Terra Valente Xavier Ximenes}

FactoryGirl.define do
	sequence :nome do |n|
		nomes.sample
	end
	
	sequence :sobrenome do |n|
		sobrenomes.sample
	end
	
	sequence :nome_completo do |n|
		"#{FactoryGirl.generate(:nome)} #{FactoryGirl.generate(:sobrenome)}"
	end
	
	sequence :email do |n|
		"#{FactoryGirl.generate(:nome).downcase.remover_acentos}_#{FactoryGirl.generate(:sobrenome).downcase.remover_acentos}@gmail.com"
	end
end