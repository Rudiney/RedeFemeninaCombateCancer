class Privado::UsersController < PrivadoController
	
	before_filter :deve_ser_admin
	
	include Crud
	
	def initialize
		@modelo = User
		super
	end
	
	def menu_ativo
		:users
	end
		
	def deve_ser_admin
		redirect_to(new_user_session_path) unless current_user.is_admin?
	end
end
