# encoding: UTF-8

class RelatorioAtividade
	
	AGRUPAMENTOS_POSSIVEIS = {
		'Mês'          => :mes,
		'Paciente'     => :paciente,
		'Serviço'      => :servico,
		'Produto'      => :produto,
		'Profissional' => :profissional
	}
	
	attr_accessor :data_inicial,:data_final,:pacientes_ids,:profissionais_ids,
	:servicos_ids, :agrupar_por, :produtos_ids


	def produtos_entregues
		@produtos_entregues ||= busca_produtos_entregues
	end

	def servicos_prestados
		@servicos_prestados ||= busca_servicos_prestados
	end

	private

	def busca_produtos_entregues
		@produtos_entregues = ProdutoSolicitacaoProduto.entregue.order('solicitacoes_produtos.entregue_dia')

		private_methods.grep(/filtra_produtos_por/).each{|m| send(m) }

		@produtos_entregues = @produtos_entregues.group_by(&agrupar_por) if !agrupar_por.blank? && ProdutoSolicitacaoProduto.public_method_defined?(agrupar_por)

		return @produtos_entregues
	end

	def busca_servicos_prestados
		@servicos_prestados = SolicitacaoServico.where({})

		private_methods.grep(/filtra_servicos_por/).each{|m| send(m) }

		@servicos_prestados = @servicos_prestados.group_by(&agrupar_por) if !agrupar_por.blank? && SolicitacaoServico.public_method_defined?(agrupar_por)

		return @servicos_prestados
	end

	def filtra_servicos_por_data_inicial
		@servicos_prestados = @servicos_prestados.where('data >= ?', data_inicial) unless data_inicial.blank?
	end

	def filtra_servicos_por_data_final
		@servicos_prestados = @servicos_prestados.where('data <= ?', data_final) unless data_final.blank?
	end

	def filtra_produtos_por_data_inicial
		@produtos_entregues = @produtos_entregues.where('entregue_dia >= ?', data_inicial) unless data_inicial.blank?
	end
	
	def filtra_produtos_por_data_final
		@produtos_entregues = @produtos_entregues.where('entregue_dia <= ?', data_final) unless data_final.blank?
	end

	def filtra_produtos_por_paciente
		@produtos_entregues = @produtos_entregues.where(solicitacoes_produtos:{ paciente_id: pacientes_ids}) unless pacientes_ids.blank?
	end
	
	def filtra_servicos_por_paciente
		@servicos_prestados = @servicos_prestados.where(paciente_id: pacientes_ids) unless pacientes_ids.blank?
	end

	def filtra_servicos_por_profissional
		@servicos_prestados = @servicos_prestados.where(profissional_id: profissionais_ids) unless profissionais_ids.blank?
	end
	
	def filtra_servicos_por_servico
		@servicos_prestados = @servicos_prestados.where(servico_id: servicos_ids) unless servicos_ids.blank?
	end

	def filtra_produtos_por_produto
		@produtos_entregues = @produtos_entregues.where(produto_id: produtos_ids) unless produtos_ids.blank?
	end
end