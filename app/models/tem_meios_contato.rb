module TemMeiosContato
	
	def self.included(classe)
		classe.attr_accessible(:meios_contato_attributes)
		classe.has_many(:meios_contato, class_name: MeioContato, as: :dono, dependent: :destroy)
		classe.accepts_nested_attributes_for(:meios_contato, allow_destroy: true, 
			reject_if: lambda {|mc| mc[:tipo].blank? || mc[:valor].blank?})
	end
end