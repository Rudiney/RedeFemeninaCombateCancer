# encoding: UTF-8

require 'test_helper'

class MeioContatoTest < ActiveSupport::TestCase
	
	setup do
		@mc = FactoryGirl.build(:meio_contato)
	end
	
	test "01 - atributos obrigatórios" do
		atributo_obrigatorio(@mc, :dono_type, :tipo, :valor)
	end
	
	test "02 - meios possíveis" do
		['Tel. Residencial', 'Tel. Comercial', 'Celular', 'E-mail', 'MSN', 'Skype', 'Facebook', 'Twitter'].each do |meio|
			@mc.tipo = meio
			assert_save(@mc)
		end
		
		@mc.tipo = 'Outro tipo qualquer'
		assert(!@mc.save, "Não pudia salvar")
	end
	
	test "03 - deve pertencer a um dono" do
		voluntaria = @mc.dono_type.constantize.find(@mc.dono_id)
		assert_equal(voluntaria, @mc.dono)
	end
end