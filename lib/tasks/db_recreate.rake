# encoding: UTF-8

namespace :db do
	desc "Deleta o banco, cria o banco e roda as migrações"
	
	task :recreate => ['db:drop', 'db:create','db:migrate'] 	
end