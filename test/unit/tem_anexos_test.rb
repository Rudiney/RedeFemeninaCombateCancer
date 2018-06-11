# encoding: UTF-8

module TemAnexosTest
	
	def test_pode_ter_anexos
		assert_save(objeto)

		anexo = FactoryGirl.create(:anexo, dono: objeto)
		assert_save(anexo)

		assert(objeto.anexos.any?, "Não relacionou o anexo ao objeto #{objeto.class.name}")
		assert_equal(anexo, objeto.anexos.first)
	end
	
	def test_quando_deletar_deleta_os_anexos_tbm
		assert_save(objeto)

		assert_difference("Anexo.count", +3) do
		  FactoryGirl.create_list(:anexo, 3, dono: objeto)
		end

		assert_difference("Anexo.count", -3) do
		  objeto.destroy
		end
	end
end