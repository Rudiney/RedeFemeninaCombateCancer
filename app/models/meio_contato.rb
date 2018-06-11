class MeioContato < ActiveRecord::Base
	TIPOS_POSSIVEIS = ['Tel. Residencial', 'Tel. Comercial', 'Celular', 'E-mail', 'MSN', 'Skype', 'Facebook', 'Twitter']
	
	attr_accessible :tipo, :valor
	
	belongs_to :dono, :polymorphic => true
	
	validates :dono_type, :tipo, :valor,  presence: true
	validates :tipo, inclusion: {in: MeioContato::TIPOS_POSSIVEIS}
end