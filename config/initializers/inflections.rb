# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format
# (all these examples are active by default):
ActiveSupport::Inflector.inflections do |inflect|
	#   inflect.plural /^(ox)$/i, '\1en'
	#   inflect.singular /^(ox)en/i, '\1'
	#   inflect.irregular 'person', 'people'
	#   inflect.uncountable %w( fish sheep )
	inflect.irregular 'voluntaria', 'voluntarias'
	inflect.irregular 'profissional', 'profissionais'
	
	inflect.irregular 'meio_contato', 'meios_contatos'
	inflect.irregular 'solicitacao_produto', 'solicitacoes_produtos'
	inflect.irregular 'solicitacao_servico', 'solicitacoes_servicos'
	inflect.irregular 'tipo_voluntaria', 'tipos_voluntarias'
	inflect.irregular 'nivel_escolaridade', 'niveis_escolaridade'
	
end
#
# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections do |inflect|
#   inflect.acronym 'RESTful'
# end
