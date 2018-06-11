# encoding: UTF-8

class Anexo < ActiveRecord::Base
	
	attr_accessible :nome, :arquivo
	
	has_attached_file :arquivo
		
	validates :nome, presence: true
	validates :arquivo, attachment_presence: true
	
	belongs_to :dono, :polymorphic => true
end