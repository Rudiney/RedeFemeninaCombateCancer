# encoding: UTF-8

require 'test_helper'

class Privado::AniversariantesControllerTest < ActionController::TestCase

	setup do
		sign_in(current_user)
	end
	
	test "00 - validando a sessao" do
		sem_sessao_nao_acessa(:get, :index)
	end
	
	test "01 - busca voluntárias" do
		aniversariante = FactoryGirl.create(:voluntaria, nascimento: Date.today.change(year: 1960))
		get(:index)
		
		assert_not_nil(assigns(:aniversariantes_de_hoje))
		assert_equal(1, assigns(:aniversariantes_de_hoje).size)
		assert_equal(aniversariante, assigns(:aniversariantes_de_hoje).first)
	end
	
	test "02 - busca tbm pacientes" do
		aniversariante = FactoryGirl.create(:paciente, nascimento: Date.today.change(year: 1960))
		get(:index)
		
		assert_not_nil(assigns(:aniversariantes_de_hoje))
		assert_equal(1, assigns(:aniversariantes_de_hoje).size)
		assert_equal(aniversariante, assigns(:aniversariantes_de_hoje).first)
	end
	
	test "03 - só aniversariantes de hoje" do
		FactoryGirl.create(:voluntaria, nascimento: Date.yesterday.change(year: 1960))
		FactoryGirl.create(:paciente,   nascimento: Date.yesterday.change(year: 1960))
		FactoryGirl.create(:voluntaria, nascimento: Date.today.change(year: 1960))
		FactoryGirl.create(:paciente,   nascimento: Date.today.change(year: 1960))
		FactoryGirl.create(:voluntaria, nascimento: Date.tomorrow.change(year: 1960))
		FactoryGirl.create(:paciente,   nascimento: Date.tomorrow.change(year: 1960))
		
		get(:index)
		
		assert_not_nil(assigns(:aniversariantes_de_hoje))
		assert_equal(2, assigns(:aniversariantes_de_hoje).size)
	end
	
	test "04 - próximos aniversariantes" do
		(-15..15).each do |i|
			FactoryGirl.create([:voluntaria, :paciente].sample(), nascimento: (Date.yesterday + i.days).change(year: 1960))
		end
		
		get(:index)
		
		assert_not_nil(assigns(:aniversariantes_de_hoje))
		assert_equal(1, assigns(:aniversariantes_de_hoje).size)
		
		assert_not_nil(assigns(:proximos_aniversariantes))
		assert_equal(10, assigns(:proximos_aniversariantes).size)
	end
	
	test "05 - deve guardar a quantidade de aniversariantes num cookie" do
		aniversariante = FactoryGirl.create(:voluntaria, nascimento: Date.today.change(year: 1960))
		get(:index)
		assert_equal(1, cookies[:aniversariantes])
	end
	
	test "06 - nao pode trazer os pacientes mortos" do
		FactoryGirl.create(:paciente, :morto, nascimento: Date.today.change(year: 1960))
		FactoryGirl.create(:paciente, :morto, nascimento: Date.tomorrow.change(year: 1960))
		
		get(:index)
		
		assert(assigns(:aniversariantes_de_hoje).empty?, "nao deveria trazer o aniversariantes_de_hoje")
		assert(assigns(:proximos_aniversariantes).empty?, "nao deveria trazer o proximos_aniversariantese")
	end
	
	test "07 - quem faz aniversário hoje está aparecendo nos próximos tbm!" do
		
		ontem = FactoryGirl.create(:paciente,   nascimento: Date.yesterday.change(year: 1960))
		hoje = FactoryGirl.create(:voluntaria, nascimento: Date.today.change(year: 1960))
		amanha = FactoryGirl.create(:voluntaria, nascimento: Date.tomorrow.change(year: 1960))
		get(:index)
		
		assert_equal(1, assigns(:aniversariantes_de_hoje).size)
		assert_equal(hoje, assigns(:aniversariantes_de_hoje).first)
		
		assert_equal([amanha], assigns(:proximos_aniversariantes))
		assert_equal(1, assigns(:proximos_aniversariantes).size)
	end
end