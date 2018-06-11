# encoding: UTF-8

require 'test_helper'

class ProfissionalTest < ActiveSupport::TestCase

	include TemMeiosContatoTest
	include TemAnexosTest
	include TemDataDoCadastroTest

	setup do
		@objeto = @p = FactoryGirl.build(:profissional)
	end

	test "00 - deve salvar" do
		assert_save(@p)
	end

	test "01 - atributos obrigatórios" do
		atributo_obrigatorio(@p, :nome, :servico)
	end

	test "02 - deve ter um servico" do
		assert_has_one(@p, :servico)
	end

	test "04 - deve ter convenios e solicitacoes de servico" do
		assert_has_many(@p, :convenios, create: true)
		assert_has_many(@p, :solicitacoes_servicos)
	end
end