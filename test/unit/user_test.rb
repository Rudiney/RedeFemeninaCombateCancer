require 'test_helper'

class UserTest < ActiveSupport::TestCase
	
	include TemDataDoCadastroTest
	
	setup do
		@objeto = @u = FactoryGirl.build(:user)
	end
end
