# encoding: UTF-8

module TemAnexosControllerTest
	
	def test_ANXO_deve_ter_um_no_new
		get(:new)
		assert(assigns(nome_singular).anexos.any?, 'deveria ter pelo menos 1 anexo')
	end
	
	def test_ANXO_deve_ter_um_no_edit
		assert(objeto.anexos.empty?)
		
		get(:edit, id: objeto.to_param)
		
		assert_equal(objeto, assigns(nome_singular))
		assert(assigns(nome_singular).anexos.any?)
	end
	
	def test_ANXO_deve_criar_com_anexos
		anexos = FactoryGirl.build_list(:anexo, 2)
		
		params = {nome_singular => objeto.accessible_attributes}
		params[nome_singular][:anexos_attributes] = {}
		
		anexos.each_with_index do |an, idx|
			params[nome_singular][:anexos_attributes][idx.to_s] = {
				'nome' => an.nome,
				'arquivo' => fixture_file_upload('files/macbook.png', 'image/png')
			}
		end
		
		assert_difference("#{class_name}.count") do
			xhr(:post, :create, params)
		end
		
		assert_equal(2, assigns(nome_singular).anexos.size, 'deveria ter salvo 2 anexos')
	end

	def test_MC_deve_deletar_no_update
		FactoryGirl.create_list(:anexo, 3, dono: objeto)
		assert_equal(3, objeto.anexos.size)
		
		params = objeto.accessible_attributes
		
		objeto.anexos.each_with_index do |an, idx|
			params.deep_merge!({anexos_attributes: { idx.to_s => { id: an.id.to_s, _destroy: 1}}})
		end
		
		assert_difference("Anexo.count", -3) do
			xhr(:put, :update, id: objeto.to_param, nome_singular =>  params)
		end
		
		objeto.reload
		
		assert_equal(0, objeto.anexos.size, 'depois do update, nao pode fica nenhum')
	end
end