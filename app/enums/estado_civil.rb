# encoding: UTF-8

class EstadoCivil < ClassyEnum::Base
end

class EstadoCivil::Solteiro < EstadoCivil
	def nome
		'Solteiro'
	end
end

class EstadoCivil::Casado < EstadoCivil
	def nome
		'Casado'
	end
end

class EstadoCivil::Separado < EstadoCivil
	def nome
		'Separado'
	end
end

class EstadoCivil::Divorciado < EstadoCivil
	def nome
		'Divorciado'
	end
end

class EstadoCivil::Viuvo < EstadoCivil
	def nome
		'Viúvo'
	end
end

class EstadoCivil::UniaoEstavel < EstadoCivil
	def nome
		'União Estável'
	end
end