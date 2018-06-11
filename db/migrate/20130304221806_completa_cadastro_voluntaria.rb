class CompletaCadastroVoluntaria < ActiveRecord::Migration
	def change
		add_column :voluntarias, :areas_interesse, :text
		add_column :voluntarias, :sugestoes, :text
	end
end