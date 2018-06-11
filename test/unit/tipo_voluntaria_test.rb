# encoding: UTF-8

require 'test_helper'

class TipoVoluntariaTest < ActiveSupport::TestCase
	
	include TemDataDoCadastroTest
	
	setup do
		@objeto = @tv = FactoryGirl.build(:tipo_voluntaria)
	end
	
	test "0 - deve salvar" do
		assert(@tv.save, "não salvou: #{@tv.errors.full_messages}")
	end
	
	test "1 - atributos obrigatórios" do
		atributo_obrigatorio(@tv, :nome)
	end
	
	test "2 - deve ter voluntárias" do
		assert_save(@tv)
		vs = FactoryGirl.create_list(:voluntaria, 4, tipo_voluntaria: @tv)
		assert_equal(@tv.voluntarias.count, 4)
		assert(vs.first.in?(@tv.voluntarias), "A voluntária nao está no vetor!")
	end
end
