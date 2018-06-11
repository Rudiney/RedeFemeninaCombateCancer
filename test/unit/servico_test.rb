# encoding: UTF-8

require 'test_helper'

class ServicoTest < ActiveSupport::TestCase

	include TemDataDoCadastroTest
	
	setup do
		@objeto = @s = FactoryGirl.build(:servico)
	end
	
	test "00 - deve salvar" do
		assert_save(@s)
	end
	
	test "01 - atributos obrigatórios" do
		atributo_obrigatorio(@s, :nome)
	end
	
	test "02 - deve ter pacientes" do
		assert_has_many(@s, :pacientes)
		assert_has_many(@s, :profissionais)
		assert_has_many(@s, :solicitacoes_servicos)
	end
end