# encoding: UTF-8

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'turn'
require 'functional/crud_controller_test'
#require 'functional/crud_privado_controller_test'
require 'functional/tem_meios_contato_controller_test'
require 'functional/tem_anexos_controller_test'
require 'unit/tem_meios_contato_test'
require 'unit/tem_anexos_test'
require 'unit/tem_data_do_cadastro_test'

class ActionController::TestCase
	include Devise::TestHelpers
end

class ActiveSupport::TestCase
	
	# Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
	#
	# Note: You'll currently still have to declare fixtures explicitly in integration tests
	# -- they do not yet inherit this setting
	#fixtures :all

	# Helper para testar os atributos obrigatórios de um objeto
	# 
	# atributo_obrigatorio(@aluno, :nome, :sobrenome)
	# pode ser passado um bloco de código com mais coisas para acontecer a cada atributo testado
	def atributo_obrigatorio(objeto,*atributos, &bloco)
		atributos.each do |att|

			valor_preenchido = objeto.send(att)

			objeto.send("#{att}=",nil)
			assert(!objeto.save,"Salvou o objeto mesmo com o atributo '#{att}' nulo!")

			bloco.call(att) if bloco

			objeto.send("#{att}=",valor_preenchido)
		end
	end
	
	def assert_save(obj)
		assert(obj.save, "Não salvou o #{obj.class.name}! Erros: #{obj.errors.full_messages.join(',')}")
	end
	
	def assert_has_one(obj, relation_name)
		rel = FactoryGirl.create(relation_name)
		obj.send("#{relation_name}_id=", rel.id)
		
		assert_equal(obj.send(relation_name), rel, "Não atribuiu o #{relation_name} certo pelo #{relation_name}_id")

		obj.send("#{relation_name}_id=", 99999)
		assert(!obj.save, "Salvou mesmo com um #{relation_name} que nao exite")
	end
	
	def assert_has_many(obj, relation_name, params={})
		assert_save(obj)
		
		nome_singular = relation_name.to_s.singularize
		
		rel_obj = FactoryGirl.create(nome_singular)
		
		obj.send(relation_name) << rel_obj
		obj.reload
		
		assert(rel_obj.in?(obj.send(relation_name)), "O #{nome_singular} nao ficou salvo nos #{relation_name}")
		
		if params[:create]
			outro = FactoryGirl.create(nome_singular)
				
			obj.send("#{nome_singular}_ids=", [outro.id.to_s])
			assert_save(obj)
			assert(outro.in?(obj.send(relation_name)), "O #{nome_singular} nao ficou salvo nos #{relation_name} setando pelo #{nome_singular}_ids")
		end
	end
	
	def sem_sessao_nao_acessa(method,action,params={})
		sign_out(current_user)
		send(method, action, params)
		assert_redirected_to(new_user_session_path, "não deveria acessar a ação #{action}")
	end
	
	def objeto
		raise "Preciso de um @objeto para testar" unless @objeto
		@objeto
	end
	
	def class_name
		objeto.class.name
	end
	
	def nome_plural
		@nome_plural ||= class_name.tableize.to_sym
	end
	
	def nome_singular
		@nome_singular ||= class_name.underscore.to_sym
	end
	
	def current_user
		@user ||= FactoryGirl.create(:user)
	end
	
	def create_params
		{nome_singular =>  objeto.accessible_attributes}
	end
	
	def update_params
		{id: objeto, nome_singular => objeto.accessible_attributes}
	end
end
