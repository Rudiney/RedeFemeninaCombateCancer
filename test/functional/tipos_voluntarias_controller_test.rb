# encoding: UTF-8

require 'test_helper'

class Privado::TiposVoluntariasControllerTest < ActionController::TestCase
	
	include CrudControllerTest
	
	setup do
		@objeto = FactoryGirl.create(:tipo_voluntaria)
	end	
end