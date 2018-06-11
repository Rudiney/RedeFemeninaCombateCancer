class AddNomeEAdminNoUser < ActiveRecord::Migration
	def change
		add_column :users, :nome, :string
		add_column :users, :is_admin, :boolean
	end
end