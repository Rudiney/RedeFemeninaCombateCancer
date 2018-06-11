# encoding: UTF-8

require 'test_helper'

class Privado::SolicitacoesServicosControllerTest < ActionController::TestCase
	
	include CrudControllerTest
	
	setup do
		@objeto = FactoryGirl.create(:solicitacao_servico)
	end
	
	test "01 - deve trazer separado as passadas e as futuras" do
		passada = FactoryGirl.create(:solicitacao_servico, data: Date.yesterday)
		futura = FactoryGirl.create(:solicitacao_servico, data: Date.tomorrow)
		
		get (:index)
		assert_not_nil(assigns(:passadas))
		assert(passada.in?(assigns(:passadas)))
		
		assert_not_nil(assigns(:futuras))
		assert(futura.in?(assigns(:futuras)))
	end
end