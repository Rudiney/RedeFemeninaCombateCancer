# encoding: UTF-8

require 'test_helper'

class ConvenioTest < ActiveSupport::TestCase
	
	include TemDataDoCadastroTest
	
	setup do
		@objeto = @c = FactoryGirl.build(:convenio)
	end
	
	test "00 - deve salvar" do
		assert_save(@c)
	end
	
	test "01 - atributos obrigatórios" do
		atributo_obrigatorio(@c, :nome)
	end
	
	test "02 - deve ter profissionais" do
		@c.profissionais << p = FactoryGirl.create(:profissional)
		assert(p.in?(@c.profissionais))
	end
	
end