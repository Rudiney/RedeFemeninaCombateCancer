class Produto < ActiveRecord::Base
	
	include TemDataDoCadastro
	
	attr_accessible :nome
	
	validates :nome, presence: true
	
	has_many :pacientes_produtos, class_name: 'PacienteProduto'
	has_many :pacientes, through: :pacientes_produtos, source: :paciente
	
	has_many :solicitacoes, 
		class_name: "ProdutoSolicitacaoProduto", 
		foreign_key: "produto_id",
		dependent: :destroy
end