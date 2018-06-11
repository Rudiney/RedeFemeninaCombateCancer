# encoding: UTF-8

require 'test_helper'

class SolicitacaoProdutoTest < ActiveSupport::TestCase
	
	setup do
		@sp = FactoryGirl.build(:solicitacao_produto)
	end
	
	test "00 - deve salvar" do
		assert_save(@sp)
	end
	
	test "01 - atributos obrigatórios" do
		atributo_obrigatorio(@sp, :paciente, :solicitado_dia)
	end
	
	test "02 - deve ter um paciente" do
		p = FactoryGirl.create(:paciente)
		@sp.paciente_id = p.id
		assert_equal(@sp.paciente, p)
	end
	
	test "03 - o paciente deve existir" do
		@sp.paciente_id = 9999
		assert(!@sp.save)
	end
	
	test "04 - #entregue?" do
		@sp.entregue_dia = nil
		assert(!@sp.entregue?, "nao devia estar entregue")
		
		@sp.entregue_dia = Date.today
		assert(@sp.entregue?, "devia estar entregue")
	end
	
	test "05 - escopo dos entregues e não entregues" do
		entregue = FactoryGirl.create(:solicitacao_produto, :entregue)
		nao_entregue = FactoryGirl.create(:solicitacao_produto, :nao_entregue)
		
		assert_equal(1, SolicitacaoProduto.entregue.count)
		assert_equal(entregue, SolicitacaoProduto.entregue.first)
		
		assert_equal(1, SolicitacaoProduto.nao_entregue.count)
		assert_equal(nao_entregue, SolicitacaoProduto.nao_entregue.first)
	end
	
	test "04 - deve ter produtos solicitados" do
		psp = FactoryGirl.create(:produto_solicitacao_produto, solicitacao_produto: @sp)
		assert(psp.in?(@sp.produtos_solicitados))
	end
	
	test "05 - deve criar uma solicitação com produtos" do
		produto = FactoryGirl.create(:produto)
		
		novo = SolicitacaoProduto.new(@sp.accessible_attributes.merge(
			produtos_solicitados_attributes: {
				'0' => {produto_id: produto.id, quantidade: 4}
			} 
		))
		
		assert_save(novo)
		assert(novo.produtos_solicitados.any?)
		assert_equal(produto, novo.produtos_solicitados.first.produto)
	end

	test "06 - ao deletar a solicitação de produto, apaga o relacionamento" do
		psp = FactoryGirl.create(:produto_solicitacao_produto, solicitacao_produto: @sp)
		assert(@sp.produtos_solicitados.any?)

		assert_difference("ProdutoSolicitacaoProduto.count", -1) do
			@sp.destroy
			assert(@sp.produtos_solicitados(true).empty?)
		end
	end
	
	test "07 - deve remvoer os produtos pela solicitacao" do
		psp = FactoryGirl.create(:produto_solicitacao_produto, solicitacao_produto: @sp)
		
		assert_difference "ProdutoSolicitacaoProduto.count", -1 do
			@sp.update_attributes(@sp.accessible_attributes.merge(
				produtos_solicitados_attributes: {
					'0' => {id: psp.id, _destroy: 1}
				} 
			))
			
			assert(@sp.produtos_solicitados.empty?)
		end
	end
end