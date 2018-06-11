# encoding: UTF-8

require 'test_helper'

class Privado::ConveniosControllerTest < ActionController::TestCase	
	
	include CrudControllerTest
	
	setup do
		@objeto = FactoryGirl.create(:convenio)
	end	
end