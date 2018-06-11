# encoding: UTF-8

Voluntaria.delete_all
TipoVoluntaria.delete_all
Paciente.delete_all
Servico.delete_all
Produto.delete_all
Profissional.delete_all
Convenio.delete_all
ProdutoSolicitacaoProduto.delete_all
SolicitacaoProduto.delete_all
SolicitacaoServico.delete_all

tipos_voluntarias = TipoVoluntaria.create(['Bazar','Setor Educacional','Produção','Externas','Internas','Diretoria Executiva'].map{|n| {nome: n} })
servicos = Servico.create(['Fisioterapia','Visita domiciliar','Consulta Médica','Consulta Psicológica'].map{|n| {nome: n} })
produtos = Produto.create(['Peruca','Prótese Mamária','Medicamento','Vale Transporte','Higienodietético'].map{|n| {nome: n} })
convenios = Convenio.create(['Município','Lyons','Rede Feminina'].map{|n| {nome: n} })
 
tipos_de_cancer = ['Câncer de mama', 'Leucemia', 'Câncer de pele', 'Melanoma', 'Tumor cerebral', 'Câncer de bexiga']

def rg
	"#{rand(9)}.#{rand(9)}#{rand(9)}#{rand(9)}.#{rand(9)}#{rand(9)}#{rand(9)}"
end

def cpf
	"#{rand(9)}#{rand(9)}#{rand(9)}.#{rand(9)}#{rand(9)}#{rand(9)}.#{rand(9)}#{rand(9)}#{rand(9)}-#{rand(9)}#{rand(9)}"
end

def data
	rand((Date.today-100.year)..(Date.today-40.year))
end

def string(size)
	o =  [('a'..'z').to_a,('A'..'Z').to_a].flatten + ([' '] * 10)
	(0...size).map{ o[rand(o.length)] }.join
end

20.times do
	v = FactoryGirl.create(:voluntaria, 
		tipo_voluntaria: tipos_voluntarias.sample,
		cpf: cpf(), identidade: rg(),
		nascimento: data()
	)
	FactoryGirl.create_list(:meio_contato, 3 , dono: v)
end

pacientes = []
50.times do
	pacientes << p =  FactoryGirl.create(:paciente, [:vivo, :morto].sample,
		tipo_de_cancer: tipos_de_cancer.sample, 
		identidade: rg(), cpf: cpf(),
		nascimento: data(),
		local_nascimento: string(10),
		raca: string(5),
		profissao: string(10),
		endereco_profissional: string(15),
		nome_conjuge: FactoryGirl.generate(:nome_completo),
		profissao_conjuge: string(10),
		contato_conjuge: string(20),
		tem_filhos: [true, false].sample(),
		quantidade_filhos: rand(0..4),
		idade_filhos: string(10),
		diagnostico: string(300),
		tratamentos: string(300),
		acompanhamento_medico: string(300),
		medicamentos_utilizados: string(300),
		custo_manutencao_cancer: string(300),
		atividades: string(300),
		horario_disponibilidade: string(300),
	)
	
	FactoryGirl.create_list(:meio_contato, 3 , dono: p)
end


profissionais = []
15.times do
	profissionais << FactoryGirl.create(:profissional, servico: servicos.sample())
end

Profissional.all.each do |p|
	FactoryGirl.create(:profissional_convenio, profissional: p, convenio: convenios.sample())
end

40.times do
	sp = FactoryGirl.create(:solicitacao_produto, paciente: pacientes.sample(),
		solicitado_dia: data(),
		entregue_dia: [nil, data()].sample())
	
	[1,2,3,4].sample.times do
		FactoryGirl.create(:produto_solicitacao_produto, solicitacao_produto: sp, 
		produto: produtos.sample(), quantidade: rand(1..100))
	end
end

40.times do
	ss = FactoryGirl.create(:solicitacao_servico, 
		paciente: pacientes.sample(),
		profissional: profissionais.sample(),
		servico: servicos.sample(),
		data: data())
end