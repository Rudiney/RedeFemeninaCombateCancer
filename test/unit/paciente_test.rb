# encoding: UTF-8

require 'test_helper'

class PacienteTest < ActiveSupport::TestCase
	
	include TemMeiosContatoTest
	include TemAnexosTest
	include TemDataDoCadastroTest
	
	setup do
		@objeto = @p = FactoryGirl.build(:paciente)
	end
	
	test "0 - deve salvar" do
		assert_save(@p)
	end
	
	test "1 - atributos obrigatórios" do
		atributo_obrigatorio(@p, :nome)
	end
	
	test "2 - vivo/morto com base na data de óbito" do
		@p.obito = nil
		assert(@p.vivo?, "vivo?")
		assert(!@p.morto?, "!morto?")
		
		@p.obito = Time.now
		assert(!@p.vivo?, "!vivo?")
		assert(@p.morto?, "morto?")
	end
	
	test "3 - escopo dos pacientes vivos e mortos" do
		vivo = FactoryGirl.create(:paciente, :vivo)
		morto = FactoryGirl.create(:paciente, :morto)
		
		assert_equal(1, Paciente.vivo.count)
		assert(vivo.in?(Paciente.vivo), "paciente vivo")
		
		assert_equal(1, Paciente.morto.count)
		assert(morto.in?(Paciente.morto), "paciente morto")
	end
	
	test "04 - tem vários serviços, produtos, solicitacoes de produtos e solicitacoes de serviços" do
		assert_has_many(@p, :servicos, create: true)
		assert_has_many(@p, :produtos, create: true)
		assert_has_many(@p, :solicitacoes_produtos)
		assert_has_many(@p, :solicitacoes_servicos)
	end
	
	test "05 - escolaridades" do
		assert_has_one(@p, :escolaridade)
	end
	
	test "06 - estados civis" do
		validos = %w{ solteiro casado separado divorciado viuvo uniao_estavel }
		validos.each do |ec|
			@p.estado_civil = ec
			assert_save(@p)
		end
		
		@p.estado_civil = :qualquer_outro
		assert(!@p.valid?, "o estado civil não é válido")
	end
	
	test "12 - #idade" do
		@p.nascimento = Date.tomorrow.change(year: Date.tomorrow.year - 40)
		assert_equal(39, @p.idade)
		
		@p.nascimento = Date.today.change(year: Date.today.year - 40)
		assert_equal(40, @p.idade)
		
		@p.nascimento = Date.yesterday.change(year: Date.yesterday.year - 40)
		assert_equal(40, @p.idade)
	end
	
end