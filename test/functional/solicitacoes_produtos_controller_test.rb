# encoding: UTF-8

require 'test_helper'

class Privado::SolicitacoesProdutosControllerTest < ActionController::TestCase
	
	include CrudControllerTest
	
	setup do
		@objeto = @sp = FactoryGirl.create(:solicitacao_produto)
	end
	
	test "00 - ao criar, deve ter um produto" do
		get(:new)
		assert(assigns(:solicitacao_produto).produtos_solicitados.any?)
		assert_equal(1, assigns(:solicitacao_produto).produtos_solicitados.first.quantidade, 'deve criar com a quantidade 1')
	end
	
	test "01 - ao editar, se nao tem produtos, cria um" do
		assert(@sp.produtos_solicitados.empty?)
		
		get(:edit, id: @sp.to_param)
		assert_equal(@sp, assigns(:solicitacao_produto))
		assert(assigns(:solicitacao_produto).produtos_solicitados.any?)
		assert_equal(1, assigns(:solicitacao_produto).produtos_solicitados.first.quantidade, 'deve criar com a quantidade 1')
	end
	
	test "02 - carrega uma solicitacao atrasada" do
	
		sol_vencida = FactoryGirl.build(:solicitacao_produto, :entregue)
			
		FactoryGirl.create(:produto_solicitacao_produto, 
			solicitacao_produto: sol_vencida,
			valido_ate: Date.yesterday)
			
		get(:index)
		assert_not_nil(assigns(:vencidas))
		assert(sol_vencida.in?(assigns(:vencidas)), "deveria estar nas vencidas")
		assert(!sol_vencida.in?(assigns(:entregues)), "nao devia estar nas entregues")
		assert(!sol_vencida.in?(assigns(:nao_entregues)), "nao devia estar nas nao entregues")
	end
end
