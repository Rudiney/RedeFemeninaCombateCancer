# encoding: UTF-8

require 'test_helper'

class Privado::ProfissionaisControllerTest < ActionController::TestCase

	include CrudControllerTest
	include TemMeiosContatoControllerTest
	include TemAnexosControllerTest

	setup do
		@objeto = FactoryGirl.create(:profissional)
	end


end