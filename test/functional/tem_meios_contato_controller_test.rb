# encoding: UTF-8

module TemMeiosContatoControllerTest
	
	def test_MC_deve_ter_um_no_new
		get(:new)
		assert(assigns(nome_singular).meios_contato.any?, 'deveria ter pelo menos 1 meio de contato')
	end
	
	def test_MC_deve_ter_um_no_edit
		assert(@objeto.meios_contato.empty?)
		
		get(:edit, id: @objeto.to_param)
		
		assert_equal(@objeto, assigns(nome_singular))
		assert(assigns(nome_singular).meios_contato.any?)
	end
	
	def test_MC_deve_criar_com_meios_de_contato
		assert_difference "#{class_name}.count" do
			xhr(:post, :create, nome_singular =>  @objeto.accessible_attributes.merge({
				meios_contato_attributes: {
					'0' => {tipo: 'Tel. Residencial', valor: '412341234'},
					'1' => {tipo: 'E-mail', valor: 'teste@teste'}
				}
			}))
		end
		
		assert_equal(2, assigns(nome_singular).meios_contato.size, 'deveria ter salvo 2 meios de contato')
	end

	def test_MC_deve_deletar_no_update
		FactoryGirl.create_list(:meio_contato, 3, dono: @objeto)
		assert_equal(3, @objeto.meios_contato.size)
		
		params = @objeto.accessible_attributes
		
		@objeto.meios_contato.each_with_index do |mc, idx|
			params.deep_merge!({meios_contato_attributes: { idx.to_s => { id: mc.id.to_s, tipo: mc.tipo, valor: mc.valor, _destroy: 1}}})
		end
		
		assert_difference("MeioContato.count", -3) do
			xhr(:put, :update, id: @objeto.to_param, nome_singular =>  params)
		end
		
		@objeto.reload
		
		assert_equal(0, @objeto.meios_contato.size, 'depois do update, nao pode fica nenhum')
	end
end