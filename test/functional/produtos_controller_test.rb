# encoding: UTF-8

require 'test_helper'

class Privado::ProdutosControllerTest < ActionController::TestCase
	
	include CrudControllerTest
	
	setup do
		@objeto = FactoryGirl.create(:produto)
	end	
end