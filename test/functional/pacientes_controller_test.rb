# encoding: UTF-8

require 'test_helper'

class Privado::PacientesControllerTest < ActionController::TestCase
	
	include CrudControllerTest
	include TemMeiosContatoControllerTest
	include TemAnexosControllerTest
	
	setup do
		@objeto = FactoryGirl.create(:paciente)
	end
	
	test "01 - carrega pacientes vivos e mortos" do
		FactoryGirl.create(:paciente, :vivo)
		FactoryGirl.create(:paciente, :morto)
		
		get(:index)
		assert_not_nil(assigns(:pacientes))
		assert(assigns(:pacientes).first.vivo?, "nao trouxe vivo")
		
		assert_not_nil(assigns(:pacientes_mortos))
		assert(assigns(:pacientes_mortos).first.morto?, "nao trouxe morto")
	end
	
	test "02 - traz os mortos por ordem de obito" do
		FactoryGirl.create(:paciente, obito: Time.new(2010,1,1))
		FactoryGirl.create(:paciente, obito: Time.new(2011,1,1))
		FactoryGirl.create(:paciente, obito: Time.new(2012,1,1))
		FactoryGirl.create(:paciente, obito: Time.new(2013,1,1))
		
		get(:index)
		assigns(:pacientes_mortos).each_slice(2) do |a,b|
			next unless a && b
			
			assert(a.obito > b.obito, "está fora de ordem! #{a.obito} < #{b.obito}")
		end
	end
	
	test "03 - tela de registrar o óbito" do
		xhr(:get, :registrar_obito, id: @objeto.id)
		assert_response(:success)
		assert_equal(@objeto, assigns(:paciente))
	end
end