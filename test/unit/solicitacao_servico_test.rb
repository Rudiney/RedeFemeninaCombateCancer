# encoding: UTF-8

require 'test_helper'

class SolicitacaoServicoTest < ActiveSupport::TestCase
	
	setup do
		@ss = FactoryGirl.build(:solicitacao_servico)
	end
	
	test "00 - deve salvar" do
		assert_save(@ss)
	end
	
	test "01 - atributos obrigatórios" do
		atributo_obrigatorio(@ss, :paciente, :profissional, :data, :servico)
	end
	
	test "02 - tem 1 paciente, 1 profissional e 1 serviço" do
		assert_has_one(@ss, :paciente)
		assert_has_one(@ss, :profissional)
		assert_has_one(@ss, :servico)
	end
end