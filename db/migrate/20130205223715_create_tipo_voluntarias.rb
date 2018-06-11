# encoding: UTF-8

class CreateTipoVoluntarias < ActiveRecord::Migration
	def change
		create_table :tipos_voluntarias do |t|
			t.string :nome, null: false
			t.timestamps
		end
		
		TipoVoluntaria.create(['Bazar','Setor Educacional','Produção','Externas','Internas','Diretoria Executiva'].map{|n| {nome: n} })
	end
end
