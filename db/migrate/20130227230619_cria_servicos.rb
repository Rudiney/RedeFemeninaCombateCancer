# encoding: UTF-8

class CriaServicos < ActiveRecord::Migration
	def change
		create_table :servicos do |t|
		  t.string :nome, null: false
		  t.timestamps
		end
		
		Servico.create(['Fisioterapia','Visita domiciliar','Consulta Médica','Consulta Psicológica'].map{|n| {nome: n} })
	end
end