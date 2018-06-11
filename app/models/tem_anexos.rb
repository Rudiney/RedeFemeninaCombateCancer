module TemAnexos
	
	def self.included(classe)
		classe.attr_accessible(:anexos_attributes)
		classe.has_many(:anexos, class_name: Anexo, as: :dono, dependent: :destroy)
		classe.accepts_nested_attributes_for(:anexos, allow_destroy: true, 
			reject_if: lambda {|a| a[:nome].blank? || a[:arquivo].blank?})
	end
end