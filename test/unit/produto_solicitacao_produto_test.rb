# encoding: UTF-8

require 'test_helper'

class ProdutoSolicitacaoProdutoTest < ActiveSupport::TestCase
	
	setup do
		@psp = FactoryGirl.build(:produto_solicitacao_produto)
	end
	
	test "00 - deve salvar" do
		assert_save(@psp)
	end
	
	test "01 - atributos obrigatórios" do
		atributo_obrigatorio(@psp, :solicitacao_produto_id, :produto_id, :quantidade)
	end
	
	test "02 - deve pertencer a um produto" do
		produto = FactoryGirl.create(:produto)
		@psp.produto_id = produto.id
		
		assert_equal(@psp.produto, produto)
	end
	
	test "03 - deve pertencer a uma solicitacao de produto" do
		sp = FactoryGirl.create(:solicitacao_produto)
		@psp.solicitacao_produto_id = sp.id
		
		assert_equal(@psp.solicitacao_produto, sp)
	end
	
	test "04 - o produto deve existir" do
		@psp.produto_id = 999
		assert(!@psp.save)
	end
	
	test "05 - a solicitacao deve existir" do
		@psp.solicitacao_produto_id = 999
		assert(!@psp.save)
	end
	
	test "06 - a quantidade deve ser maior que 0" do
		@psp.quantidade = 0
		assert(!@psp.save)
		
		@psp.quantidade = -1
		assert(!@psp.save)
	end
end