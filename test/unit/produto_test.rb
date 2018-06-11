# encoding: UTF-8

require 'test_helper'

class ProdutoTest < ActiveSupport::TestCase
	
	include TemDataDoCadastroTest
	
	setup do
		@objeto = @pr = FactoryGirl.build(:produto)
	end
	
	test "00 - deve salvar" do
		assert_save(@pr)
	end
	
	test "01 - atributos obrigatórios" do
		atributo_obrigatorio(@pr, :nome)
	end
	
	test "02 - deve ter pacientes" do
		assert_has_many(@pr, :pacientes)
	end
	
	test "03 - deve ter solicitacoes" do
		psp = FactoryGirl.create(:produto_solicitacao_produto, produto: @pr)
		assert(psp.in?(@pr.solicitacoes))
	end
	
	test "04 - ao deletar o produto remove das solicitacoes" do
		psp = FactoryGirl.create(:produto_solicitacao_produto, produto: @pr)
		assert(@pr.solicitacoes.any?)

		assert_difference("ProdutoSolicitacaoProduto.count", -1) do
			@pr.destroy
			assert(@pr.solicitacoes(true).empty?)
		end
	end
	
end