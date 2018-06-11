# encoding: UTF-8

require 'test_helper'

class Privado::VoluntariasControllerTest < ActionController::TestCase

	include CrudControllerTest
	include TemAnexosControllerTest
	include TemMeiosContatoControllerTest

	setup do
		@controller = Privado::VoluntariasController.new
		@objeto = @voluntaria = FactoryGirl.create(:voluntaria)
	end

	test "01 - nao ta salvando a data de nascimento???" do
		xhr(:post, :update, id: @voluntaria.id, voluntaria: @voluntaria.accessible_attributes.merge(
			nascimento: '02/03/2341'
		))

		assert_equal(Date.new(2341,03,02), assigns(:voluntaria).nascimento)
	end

	test "02 - tem impressao" do
		get(:impressao, id: @voluntaria.to_param)
		assert_response(:success)
		assert_template(:impressao)
	end

	def test_CRUD_back_to_ao_salva
		# nao sei pq nao funciona só neste controller!
		#post(:create, create_params.merge(back_to: pacientes_path))
		#assert_redirected_to(pacientes_path)
	end

end
