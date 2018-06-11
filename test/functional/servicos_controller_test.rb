# encoding: UTF-8

require 'test_helper'

class Privado::ServicosControllerTest < ActionController::TestCase
	
	include CrudControllerTest
	
	setup do
		@objeto = FactoryGirl.create(:servico)
	end	
end