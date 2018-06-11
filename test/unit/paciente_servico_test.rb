# encoding: UTF-8

require 'test_helper'

class PacienteServicoTest < ActiveSupport::TestCase
	
	setup do
		@ps = FactoryGirl.build(:paciente_servico)
	end
	
	test "00 - deve salvar" do
		assert_save(@ps)
	end
	
	test "01 - atributos obrigatórios" do
		atributo_obrigatorio(@ps, :paciente_id, :servico_id)
	end
	
	test "02 - deve pertencer a um paciente" do
		paciente = FactoryGirl.create(:paciente)
		@ps.paciente_id = paciente.id
		
		assert_equal(@ps.paciente, paciente)
	end
	
	test "03 - deve pertencer a um servico" do
		servico = FactoryGirl.create(:servico)
		@ps.servico_id = servico.id
		
		assert_equal(@ps.servico, servico)
	end
	
	test "04 - o paciente deve existir" do
		@ps.paciente_id = 999
		assert(!@ps.save)
	end
	
	test "05 - o servico deve existir" do
		@ps.servico_id = 999
		assert(!@ps.save)
	end

	
	
end
