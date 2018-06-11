# encoding: UTF-8

module TemMeiosContatoTest
	
	def test_pode_ter_meios_de_contato
		assert_save(objeto)

		mc = FactoryGirl.create(:meio_contato, dono: objeto)
		assert_save(mc)

		assert(objeto.meios_contato.any?, "Não relacionou o meio de contato ao objeto #{objeto.class.name}")
		assert_equal(mc, objeto.meios_contato.first)		
	end
	
	def test_quando_deletar_deleta_os_meios_de_contato_tbm
		assert_save(objeto)

		assert_difference("MeioContato.count", +3) do
		  FactoryGirl.create_list(:meio_contato, 3, dono: objeto)
		end

		assert_difference("MeioContato.count", -3) do
		  objeto.destroy
		end
	end
end