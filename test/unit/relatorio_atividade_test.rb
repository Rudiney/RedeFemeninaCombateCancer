# encoding: UTF-8

require 'test_helper'

class RelatorioAtividadeTest < ActiveSupport::TestCase
	
	setup do
		@rel = FactoryGirl.build(:relatorio_atividade)
	end
	
	test "00 - sem filtrar nada" do
		produtos = FactoryGirl.create_list(:produto_solicitacao_produto, 2)
		servicos = FactoryGirl.create_list(:solicitacao_servico, 2)
		
		assert_equal(2, @rel.produtos_entregues.size)
		assert_equal(2, @rel.servicos_prestados.size)
	end
	
	test "01 - nao traz solicitacao de produto sem produto" do
		sp = FactoryGirl.create(:solicitacao_produto)
		assert_equal(@rel.produtos_entregues.size, 0)
	end
	
	test "02 - filtrando a data inicial" do
		@rel.data_inicial = Date.today
		
		servico_ontem  = FactoryGirl.create(:solicitacao_servico, data: Date.yesterday)
		servico_hoje   = FactoryGirl.create(:solicitacao_servico, data: Date.today)
		servico_amanha = FactoryGirl.create(:solicitacao_servico, data: Date.tomorrow)

		assert_equal(2, @rel.servicos_prestados.size)
		assert(!servico_ontem.in?(@rel.servicos_prestados))
		assert(servico_hoje.in?(@rel.servicos_prestados))
		assert(servico_amanha.in?(@rel.servicos_prestados))

		
		produto_nao_entregue = FactoryGirl.create(:produto_solicitacao_produto, :nao_entregue)
		produto_ontem        = FactoryGirl.create(:produto_solicitacao_produto, entregue_dia: Date.yesterday)
		produto_hoje         = FactoryGirl.create(:produto_solicitacao_produto, entregue_dia: Date.today)
		produto_amanha       = FactoryGirl.create(:produto_solicitacao_produto, entregue_dia: Date.tomorrow)
		
		
		assert_equal(2, @rel.produtos_entregues.size)
		assert(!produto_nao_entregue.in?(@rel.produtos_entregues))
		assert(!produto_ontem.in?(@rel.produtos_entregues))
		assert(produto_hoje.in?(@rel.produtos_entregues))
		assert(produto_amanha.in?(@rel.produtos_entregues))
	end
	
	test "03 - filtrando a data final" do
		@rel.data_final = Date.today
		
		servico_ontem  = FactoryGirl.create(:solicitacao_servico, data: Date.yesterday)
		servico_hoje   = FactoryGirl.create(:solicitacao_servico, data: Date.today)
		servico_amanha = FactoryGirl.create(:solicitacao_servico, data: Date.tomorrow)

		assert_equal(2, @rel.servicos_prestados.size)
		assert(servico_ontem.in?(@rel.servicos_prestados))
		assert(servico_hoje.in?(@rel.servicos_prestados))
		assert(!servico_amanha.in?(@rel.servicos_prestados))

		
		produto_nao_entregue  = FactoryGirl.create(:produto_solicitacao_produto, :nao_entregue)
		produto_ontem  = FactoryGirl.create(:produto_solicitacao_produto, entregue_dia: Date.yesterday)
		produto_hoje   = FactoryGirl.create(:produto_solicitacao_produto, entregue_dia: Date.today)
		produto_amanha = FactoryGirl.create(:produto_solicitacao_produto, entregue_dia: Date.tomorrow)
		
		assert_equal(2, @rel.produtos_entregues.size)
		assert(!produto_nao_entregue.in?(@rel.produtos_entregues))
		assert(produto_ontem.in?(@rel.produtos_entregues))
		assert(produto_hoje.in?(@rel.produtos_entregues))
		assert(!produto_amanha.in?(@rel.produtos_entregues))
	end
	
	test "04 - filtrando os pacientes" do
		p1 = FactoryGirl.create(:paciente)
		p2 = FactoryGirl.create(:paciente)
		
		sp1 = FactoryGirl.create(:solicitacao_servico, paciente: p1)
		sp2 = FactoryGirl.create(:solicitacao_servico, paciente: p2)
		
		pp1 = FactoryGirl.create(:produto_solicitacao_produto, paciente: p1)
		pp2 = FactoryGirl.create(:produto_solicitacao_produto, paciente: p2)
		
		@rel.pacientes_ids = [p1.id]
		
		assert_equal(1, @rel.servicos_prestados.size)
		assert(sp1.in?(@rel.servicos_prestados))
		assert(!sp2.in?(@rel.servicos_prestados))
		
		assert_equal(1, @rel.produtos_entregues.size)
		assert(pp1.in?(@rel.produtos_entregues))
		assert(!pp2.in?(@rel.produtos_entregues))
	end
	
	test "05 - filtrando os profissionais" do
		p1 = FactoryGirl.create(:profissional)
		p2 = FactoryGirl.create(:profissional)
		
		sp1 = FactoryGirl.create(:solicitacao_servico, profissional: p1)
		sp2 = FactoryGirl.create(:solicitacao_servico, profissional: p2)
		
		#solicitacao_produto nao tem profissional
		pp1 = FactoryGirl.create(:produto_solicitacao_produto)
		
		@rel.profissionais_ids = [p1.id]
		
		assert_equal(1, @rel.servicos_prestados.size)
		assert(sp1.in?(@rel.servicos_prestados))
		assert(!sp2.in?(@rel.servicos_prestados))
		
		assert_equal(1, @rel.produtos_entregues.size)
		assert(pp1.in?(@rel.produtos_entregues))
	end
	
	test "06 - filtrando os serviços" do
		s1 = FactoryGirl.create(:servico)
		s2 = FactoryGirl.create(:servico)
		
		ss1 = FactoryGirl.create(:solicitacao_servico, servico: s1)
		ss2 = FactoryGirl.create(:solicitacao_servico, servico: s2)
		
		#solicitacao_produto nao tem serviço
		pp1 = FactoryGirl.create(:produto_solicitacao_produto)
		
		@rel.servicos_ids = [s1.id]
		
		assert_equal(1, @rel.servicos_prestados.size)
		assert(ss1.in?(@rel.servicos_prestados))
		assert(!ss2.in?(@rel.servicos_prestados))
		
		assert_equal(1, @rel.produtos_entregues.size)
		assert(pp1.in?(@rel.produtos_entregues))
	end
	
	test "07 - filtrando os produtos" do
		p1 = FactoryGirl.create(:produto)
		p2 = FactoryGirl.create(:produto)
		
		#solicitacao_servico nao tem produto
		ss1 = FactoryGirl.create(:solicitacao_servico)
		
		
		s1p1 = FactoryGirl.create(:produto_solicitacao_produto, produto: p1)
		s2p2 = FactoryGirl.create(:produto_solicitacao_produto, produto: p2)
			
		s3p1 = FactoryGirl.create(:produto_solicitacao_produto, produto: p1)
		s3p2 = FactoryGirl.create(:produto_solicitacao_produto, produto: p2)
		
		
		@rel.produtos_ids = [p1.id]
		
		assert_equal(1, @rel.servicos_prestados.size)
		assert(ss1.in?(@rel.servicos_prestados))
		
		assert_equal(2, @rel.produtos_entregues.size)
		assert(s1p1.in?(@rel.produtos_entregues))
		assert(!s2p2.in?(@rel.produtos_entregues))
		assert(s3p1.in?(@rel.produtos_entregues))
		assert(!s3p2.in?(@rel.produtos_entregues))
	end
	
	test "07.1 - uma solicitacao com produtos duplicados traz 2 vezes" do
		p1 = FactoryGirl.create(:produto)
		
		sp1 = FactoryGirl.create(:solicitacao_produto, :entregue)
		psp1 = FactoryGirl.create(:produto_solicitacao_produto, solicitacao_produto: sp1, produto: p1, quantidade: 1)
		psp2 = FactoryGirl.create(:produto_solicitacao_produto, solicitacao_produto: sp1, produto: p1, quantidade: 2)
		
		@rel.produtos_ids = [p1.id]
		
		assert_equal(2, @rel.produtos_entregues.size)
	end
	
	test "08 - agrupando por mês" do
		ssm1 = FactoryGirl.create(:solicitacao_servico, data: Date.new(2012,1,20))
		ssm2 = FactoryGirl.create(:solicitacao_servico, data: Date.new(2012,2,20))
		ss2m2 = FactoryGirl.create(:solicitacao_servico, data: Date.new(2012,2,21))
		
		spm1  = FactoryGirl.create(:produto_solicitacao_produto, entregue_dia: Date.new(2012,1,20))
		spm2  = FactoryGirl.create(:produto_solicitacao_produto, entregue_dia: Date.new(2012,2,20))
		sp2m2 = FactoryGirl.create(:produto_solicitacao_produto, entregue_dia: Date.new(2012,2,21))
		
		@rel.agrupar_por = :mes
		
		assert_equal(2, @rel.servicos_prestados.size)
		assert_equal(1, @rel.servicos_prestados[1].size)
		assert(ssm1.in?(@rel.servicos_prestados[1]))
		assert_equal(2, @rel.servicos_prestados[2].size)
		assert(ssm2.in?(@rel.servicos_prestados[2]))
		assert(ss2m2.in?(@rel.servicos_prestados[2]))
		
		assert_equal(2, @rel.produtos_entregues.size)
		assert_equal(1, @rel.produtos_entregues[1].size)
		assert(spm1.in?(@rel.produtos_entregues[1]))
		assert_equal(2, @rel.produtos_entregues[2].size)
		assert(spm2.in?(@rel.produtos_entregues[2]))
		assert(sp2m2.in?(@rel.produtos_entregues[2]))
	end
	
	test "09 - agrupando por paciente" do
		p1 = FactoryGirl.create(:paciente)
		p2 = FactoryGirl.create(:paciente)
		
		ssp1  = FactoryGirl.create(:solicitacao_servico, paciente: p1)
		ssp2  = FactoryGirl.create(:solicitacao_servico, paciente: p2)
		ss2p2 = FactoryGirl.create(:solicitacao_servico, paciente: p2)
		
		spp1  = FactoryGirl.create(:produto_solicitacao_produto, paciente: p1)
		spp2  = FactoryGirl.create(:produto_solicitacao_produto, paciente: p2)
		sp2p2 = FactoryGirl.create(:produto_solicitacao_produto, paciente: p2)
				
		@rel.agrupar_por = :paciente
		
		assert_equal(2, @rel.servicos_prestados.size)
		assert_equal(1, @rel.servicos_prestados[p1].size)
		assert(ssp1.in?(@rel.servicos_prestados[p1]))
		
		assert_equal(2, @rel.servicos_prestados[p2].size)
		assert(ssp2.in?(@rel.servicos_prestados[p2]))
		assert(ss2p2.in?(@rel.servicos_prestados[p2]))
		
		
		assert_equal(2, @rel.produtos_entregues.size)
		assert_equal(1, @rel.produtos_entregues[p1].size)
		assert(spp1.in?(@rel.produtos_entregues[p1]))
		
		assert_equal(2, @rel.produtos_entregues[p2].size)
		assert(spp2.in?(@rel.produtos_entregues[p2]))
		assert(sp2p2.in?(@rel.produtos_entregues[p2]))
	end
	
	test "10 - agrupando por servico" do
		
		s1 = FactoryGirl.create(:servico)
		s2 = FactoryGirl.create(:servico)
		
		sss1  = FactoryGirl.create(:solicitacao_servico, servico: s1)
		sss2  = FactoryGirl.create(:solicitacao_servico, servico: s2)
		ss2s2 = FactoryGirl.create(:solicitacao_servico, servico: s2)

		#solicitacao_produto nao tem serviço
		sp1  = FactoryGirl.create(:produto_solicitacao_produto)
		sp2  = FactoryGirl.create(:produto_solicitacao_produto)
		
		@rel.agrupar_por = :servico
		
		assert_equal(2, @rel.servicos_prestados.size)
		assert_equal(1, @rel.servicos_prestados[s1].size)
		assert(sss1.in?(@rel.servicos_prestados[s1]))
		
		assert_equal(2, @rel.servicos_prestados[s2].size)
		assert(sss2.in?(@rel.servicos_prestados[s2]))
		assert(ss2s2.in?(@rel.servicos_prestados[s2]))
		
		
		assert_equal(2, @rel.produtos_entregues.size)
	end
	
	test "11 - agrupando por produto" do
		
		p1 = FactoryGirl.create(:produto)
		p2 = FactoryGirl.create(:produto)
		
		#solicitacao_servico nao tem produto
		sss1  = FactoryGirl.create(:solicitacao_servico)
		sss2  = FactoryGirl.create(:solicitacao_servico)

		sp1p1  = FactoryGirl.create(:produto_solicitacao_produto, produto: p1)
		sp2p1  = FactoryGirl.create(:produto_solicitacao_produto, produto: p1)
		sp2p2  = FactoryGirl.create(:produto_solicitacao_produto, produto: p2)
		
		@rel.agrupar_por = :produto
		
		
		assert_equal(2, @rel.servicos_prestados.size)
		
		assert_equal(2, @rel.produtos_entregues.size)
		
		assert_equal(2, @rel.produtos_entregues[p1].size)
		assert(sp1p1.in?(@rel.produtos_entregues[p1]))
		assert(sp2p1.in?(@rel.produtos_entregues[p1]))
		
		assert_equal(1, @rel.produtos_entregues[p2].size)
		assert(sp2p2.in?(@rel.produtos_entregues[p2]))
		
	end
	
	test "12 - agrupando por profissional" do
		
		p1 = FactoryGirl.create(:profissional)
		p2 = FactoryGirl.create(:profissional)
		
		ssp1  = FactoryGirl.create(:solicitacao_servico, profissional: p1)
		ssp2  = FactoryGirl.create(:solicitacao_servico, profissional: p2)
		ss2p2 = FactoryGirl.create(:solicitacao_servico, profissional: p2)

		#solicitacao_produto nao tem profissional
		sp1  = FactoryGirl.create(:produto_solicitacao_produto)
		sp2  = FactoryGirl.create(:produto_solicitacao_produto)
		
		@rel.agrupar_por = :profissional
		
		assert_equal(2, @rel.servicos_prestados.size)
		assert_equal(1, @rel.servicos_prestados[p1].size)
		assert(ssp1.in?(@rel.servicos_prestados[p1]))
		
		assert_equal(2, @rel.servicos_prestados[p2].size)
		assert(ssp2.in?(@rel.servicos_prestados[p2]))
		assert(ss2p2.in?(@rel.servicos_prestados[p2]))
		
		
		assert_equal(2, @rel.produtos_entregues.size)
	end
	
	test "13 - agrupamentos possíveis" do
		[:mes, :paciente, :servico, :profissional, :produto ].each do |g|
			assert(g.in?(RelatorioAtividade::AGRUPAMENTOS_POSSIVEIS.values), "deveria poder agrupar por #{g}")
		end
	end
	
	test "14 - nao pode trazer produtos não entregues" do
		psp = FactoryGirl.create(:produto_solicitacao_produto, :nao_entregue)
		
		assert_nil(psp.solicitacao_produto.entregue_dia)
		
		@rel.agrupar_por = :mes
		
		assert_equal(0, @rel.produtos_entregues.size)
		assert(!psp.in?(@rel.produtos_entregues), "nao devia estar")
	end
end