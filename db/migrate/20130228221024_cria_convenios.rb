# encoding: UTF-8

class CriaConvenios < ActiveRecord::Migration
	def change
		create_table :convenios do |t|
			t.string :nome, null: false
			t.timestamps
		end
		
		Convenio.create(['Município','Lyons','Rede Feminina'].map{|n| {nome: n} })
	end
end