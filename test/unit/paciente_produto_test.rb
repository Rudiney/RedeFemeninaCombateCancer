# encoding: UTF-8

require 'test_helper'

class PacienteProdutoTest < ActiveSupport::TestCase
	
	setup do
		@pp = FactoryGirl.build(:paciente_produto)
	end
	
	test "00 - deve salvar" do
		assert_save(@pp)
	end
	
	test "01 - atributos obrigatórios" do
		atributo_obrigatorio(@pp, :paciente_id, :produto_id)
	end
	
	test "02 - deve pertencer a um paciente" do
		paciente = FactoryGirl.create(:paciente)
		@pp.paciente_id = paciente.id
		
		assert_equal(@pp.paciente, paciente)
	end
	
	test "03 - deve pertencer a um produto" do
		produto = FactoryGirl.create(:produto)
		@pp.produto_id = produto.id
		
		assert_equal(@pp.produto, produto)
	end
	
	test "04 - o paciente deve existir" do
		@pp.paciente_id = 999
		assert(!@pp.save)
	end
	
	test "05 - o produto deve existir" do
		@pp.produto_id = 999
		assert(!@pp.save)
	end
end
