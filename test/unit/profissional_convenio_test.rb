# encoding: UTF-8

require 'test_helper'

class ProfissionalConvenioTest < ActiveSupport::TestCase
	
	setup do
		@pc = FactoryGirl.build(:profissional_convenio)
	end
	
	test "00 - deve salvar" do
		assert_save(@pc)
	end
	
	test "01 - atributos obrigatórios" do
		atributo_obrigatorio(@pc, :profissional_id, :convenio_id)
	end
	
	test "02 - deve pertencer a um profissional" do
		profissional = FactoryGirl.create(:profissional)
		@pc.profissional_id = profissional.id
		
		assert_equal(@pc.profissional, profissional)
	end
	
	test "03 - deve pertencer a um convenio" do
		convenio = FactoryGirl.create(:convenio)
		@pc.convenio_id = convenio.id
		
		assert_equal(@pc.convenio, convenio)
	end
	
	test "04 - o profisisonal deve existir" do
		@pc.profissional_id = 999
		assert(!@pc.save)
	end
	
	test "05 - o convenio deve existir" do
		@pc.convenio_id = 999
		assert(!@pc.save)
	end
end
