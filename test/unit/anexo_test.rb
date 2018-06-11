# encoding: UTF-8

require 'test_helper'

class AnexoTest < ActiveSupport::TestCase
	
	setup do
		@a = FactoryGirl.build(:anexo)
	end
	
	test "00 - deve salvar" do
		assert_save(@a)
	end
	
	test "01 - atributos obrigatórios" do
		atributo_obrigatorio(@a, :nome, :arquivo)
	end

	test "02 - deve pertencer a um dono" do
		paciente = FactoryGirl.create(:paciente)
		@a.dono = paciente
		assert_save(@a)
		@a.reload
		assert_equal(paciente, @a.dono)
	end
end
