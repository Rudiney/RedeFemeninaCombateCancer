# encoding: UTF-8

module TemDataDoCadastro
	def self.included(classe)
		classe.before_validation(:data_do_cadastro_padrao)
		classe.attr_accessible(:data_do_cadastro, :observacao)
	end
	

	def data_do_cadastro_padrao
		self.data_do_cadastro = Date.today if self.data_do_cadastro.blank?
	end
end
