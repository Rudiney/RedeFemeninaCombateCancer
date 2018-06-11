# encoding: UTF-8

require 'test_helper'

class Privado::NiveisEscolaridadeControllerTest < ActionController::TestCase
	
	include CrudControllerTest
	
	setup do
		@objeto = FactoryGirl.create(:nivel_escolaridade)
	end	
end