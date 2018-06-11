# encoding: UTF-8

require 'test_helper'

class Privado::RelatorioAtividadeControllerTest < ActionController::TestCase
	
	setup do
		sign_in(current_user)
	end

	test "00 - validando a sessao" do
		sem_sessao_nao_acessa(:get, :index)
		sem_sessao_nao_acessa(:post, :show)
	end

	test "00 - deve ter o index" do
		FactoryGirl.create(:paciente)
		FactoryGirl.create(:profissional)
		FactoryGirl.create(:servico)
		FactoryGirl.create(:produto)
		
		get(:index)
		assert_response(:success)
		assert_equal(1, assigns(:pacientes).size, 'pacientes')
		assert_equal(1, assigns(:profissionais).size, 'profissionais')
		assert_equal(1, assigns(:produtos).size, 'produtos')
		
		# ao criar o profissional, cria-se um servico....
		assert_equal(2, assigns(:servicos).size, 'servicos')
		
		assert_equal(:relatorio_atividade, assigns(:menu_ativo))
	end
	
	test "01 - post filtrar" do
		paci = FactoryGirl.create(:paciente)
		prof = FactoryGirl.create(:profissional)
		serv = FactoryGirl.create(:servico)
		prod = FactoryGirl.create(:produto)
		
		post(:show, {filtros: {
			data_inicial: '01/02/2013',
			data_final: '25/12/2013',
			pacientes_ids: [paci.id.to_s],
			profissionais_ids: [prof.id.to_s],
			produtos_ids: [prod.id.to_s],
			servicos_ids: [serv.id.to_s],
			agrupar_por: 'mes'
		}})
		
		rel = assigns(:relatorio)
		assert_not_nil(rel)
		assert_equal(Date.new(2013,2,1), rel.data_inicial)
		assert_equal(Date.new(2013,12,25), rel.data_final)
		assert_equal([paci.id.to_s], rel.pacientes_ids)
		assert_equal([prof.id.to_s], rel.profissionais_ids)
		assert_equal([prod.id.to_s], rel.produtos_ids)
		assert_equal([serv.id.to_s], rel.servicos_ids)
		assert_equal(:mes, rel.agrupar_por)
	end
	
	test "02 - parametros em branco da problema" do
		post(:show, {filtros: {
			data_inicial: '',
			data_final: '',
			pacientes_ids: [""],
			profissionais_ids: [""],
			produtos_ids: [""],
			servicos_ids: [""],
			agrupar_por: 'mes'
		}})
		
		rel = assigns(:relatorio)
		assert_not_nil(rel)
		assert_equal(nil, rel.data_inicial)
		assert_equal(nil, rel.data_final)
		assert_equal([], rel.pacientes_ids)
		assert_equal([], rel.profissionais_ids)
		assert_equal([], rel.produtos_ids)
		assert_equal([], rel.servicos_ids)
	end

end