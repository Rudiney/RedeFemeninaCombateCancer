# encoding: UTF-8

require 'test_helper'

class VoluntariaTest < ActiveSupport::TestCase
	
	include TemMeiosContatoTest
	include TemAnexosTest
	include TemDataDoCadastroTest
	
	setup do
		@objeto = @v = FactoryGirl.build(:voluntaria)
	end
	
	test "01 - deve salvar" do
		assert(@v.save, "erros: #{@v.errors.full_messages}")
	end
	
	test "02 - atributos obrigatórios" do
		atributo_obrigatorio(@v, :nome, :nascimento, :estado_civil, :escolaridade, :tipo_voluntaria)
	end
	
	test "05 - estados civis" do
		validos = %w{ solteiro casado separado divorciado viuvo uniao_estavel }
		validos.each do |ec|
			@v.estado_civil = ec
			assert_save(@v)
		end
		
		@v.estado_civil = :qualquer_outro
		assert(!@v.valid?, "o estado civil não é válido")
	end
	
	test "06 - escolaridades" do
		assert_has_one(@v, :escolaridade)
	end
	
	test "07 - deve ter um tipo de voluntária" do
		@v.tipo_voluntaria_id = 98765
		assert(!@v.save, "nao deveria ter salvo")
		
		tv = @v.tipo_voluntaria = FactoryGirl.create(:tipo_voluntaria)
		
		assert_save(@v)
		assert_equal(tv, @v.tipo_voluntaria)
	end
	
	test "10 - escopo de atuante e nao atuante" do
		FactoryGirl.create(:voluntaria, atuante: true)
		FactoryGirl.create(:voluntaria, atuante: false)
		
		assert_equal(1, Voluntaria.atuante.count, 'atuantes')
		assert_equal(1, Voluntaria.nao_atuante.count, 'nao atuantes')
	end
	
	test "11 - quando diz q se tornou atuante, sava a data de ativacao" do
		@v.atuante = false
		assert_save(@v)
		
		@v.atuante = true
		assert_not_nil(@v.ativada_em)
		assert_equal(Date.today, @v.ativada_em.to_date, 'nao colocou a data certa')
		
		antes = @v.ativada_em
		
		@v.atuante = false
		assert_nil(@v.ativada_em)
		
		@v.atuante = true
		assert_not_nil(@v.ativada_em)
		assert_equal(Date.today, @v.ativada_em.to_date, 'nao colocou a data certa')
		assert(antes < @v.ativada_em, "cada vez que coloca como atuante, tem que a tualiza a data de ativação")
	end
	
	test "12 - #idade" do
		@v.nascimento = Date.tomorrow.change(year: Date.tomorrow.year - 40)
		assert_equal(39, @v.idade)
		
		@v.nascimento = Date.today.change(year: Date.today.year - 40)
		assert_equal(40, @v.idade)
		
		@v.nascimento = Date.yesterday.change(year: Date.yesterday.year - 40)
		assert_equal(40, @v.idade)
	end
end
