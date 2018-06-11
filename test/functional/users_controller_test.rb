# encoding: UTF-8

require 'test_helper'

class Privado::UsersControllerTest < ActionController::TestCase
	
	include CrudControllerTest
	
	test "usuário normal nao acessa" do
		usuario_normal = FactoryGirl.create(:user, is_admin: false)
		sign_in(usuario_normal)
		
		get(:index)
		assert_redirected_to(new_user_session_path, "não deveria acessar a ação index")
		
		get(:new)
		assert_redirected_to(new_user_session_path, "não deveria acessar a ação index")
		
		get(:show, id: objeto)
		assert_redirected_to(new_user_session_path, "não deveria acessar a ação show")
		
		get(:edit, id: objeto)
		assert_redirected_to(new_user_session_path, "não deveria acessar a ação edit")
		
		post(:create, create_params)
		assert_redirected_to(new_user_session_path, "não deveria acessar a ação create")
		
		post(:update, update_params)
		assert_redirected_to(new_user_session_path, "não deveria acessar a ação update")
	end
	
	setup do
		@objeto = FactoryGirl.create(:user)
	end	
	
	def current_user
		@user ||= FactoryGirl.create(:user, is_admin: true )
	end
	
	
	def create_params
		{ user: {
			nome: novo_objeto.nome,
			email: novo_objeto.email,
			password: 'novasenha1234',
			password_confirmation: 'novasenha1234'
		}}
	end
	
	def novo_objeto
		@novo_registro ||= FactoryGirl.build(:user)
	end
end