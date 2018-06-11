# encoding: UTF-8

include ActionDispatch::TestProcess

FactoryGirl.define do
	factory :anexo do
		sequence(:nome) {|n| "Anexo #{n}" }
		arquivo { fixture_file_upload(Rails.root.join('test', 'fixtures','files','macbook.png'), 'image/png') }
	end
end