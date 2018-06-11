# encoding: UTF-8

module TemDataDoCadastroTest
	def test_tem_data_do_cadastro
		@objeto.data_do_cadastro = nil
		assert_save(@objeto)
		assert_equal(Date.today, @objeto.data_do_cadastro)
		
		@objeto.data_do_cadastro = Date.tomorrow
		assert_save(@objeto)
		assert_equal(Date.tomorrow, @objeto.data_do_cadastro)
	end
	
end
