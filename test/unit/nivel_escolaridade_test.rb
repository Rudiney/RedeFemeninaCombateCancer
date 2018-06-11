# encoding: UTF-8

require 'test_helper'

class NivelEscolaridadeTest < ActiveSupport::TestCase
	
	include TemDataDoCadastroTest
	
	setup do
		@objeto = @ne = FactoryGirl.build(:nivel_escolaridade)
	end
	
	test "00 - deve salvar" do
		assert_save(@ne)
	end
	
	test "01 - atributos obrigatórios" do
		atributo_obrigatorio(@ne, :nome)
	end
	
	test "02 - deve ter pacientes e voluntarias" do
		assert_has_many(@ne, :pacientes)
		assert_has_many(@ne, :voluntarias)
	end
	
	test "03 - tamanho do nome" do
		@ne.nome = 'a'*255
		assert_save(@ne)
		
		@ne.nome = 'a'*256
		assert(!@ne.save)
	end
end