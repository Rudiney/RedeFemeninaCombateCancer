module I18n
	def self.raise_translation_missing_error(*args)
		raise args.first.to_s
	end
end

I18n.exception_handler = :raise_translation_missing_error
