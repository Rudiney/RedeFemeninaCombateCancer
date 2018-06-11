# encoding: UTF-8

require 'test_helper'

class ActiveRecordModelNamesTest < ActiveSupport::TestCase

	test "01 - deve pegar os nomes das traduções" do
		
		I18n.backend.store_translations(I18n.locale, activerecord:{ model_names:{ tipo_voluntaria: {
			singular: 'singular diferrente',
			plural: 'plural diferrente',
			human_singular: 'human_singular diferente',
			human_plural: 'human_plural diferente'
		}}} )
		
		#reload
		TipoVoluntaria.model_names(true)
		
		assert_equal('singular diferrente',      TipoVoluntaria.model_names[:singular])
		assert_equal('plural diferrente',        TipoVoluntaria.model_names[:plural])
		assert_equal('human_singular diferente', TipoVoluntaria.model_names[:human_singular])
		assert_equal('human_plural diferente',   TipoVoluntaria.model_names[:human_plural])
	end
	
	test "02 - sem a tradução, deve trazer um padrão" do
		I18n.backend.store_translations('pt-BR', activerecord:{ model_names:{ tipo_voluntaria: {
			singular: nil, plural: nil, human_singular: nil, human_plural: nil }}} )
		
		#reload
		TipoVoluntaria.model_names(true)
			
		assert_equal(TipoVoluntaria.name.underscore,                    TipoVoluntaria.model_names[:singular])
		assert_equal(TipoVoluntaria.name.underscore.pluralize,          TipoVoluntaria.model_names[:plural])
		assert_equal(TipoVoluntaria.model_name.human,                   TipoVoluntaria.model_names[:human_singular])
		assert_equal(TipoVoluntaria.name.underscore.pluralize.humanize, TipoVoluntaria.model_names[:human_plural])		
	end
end