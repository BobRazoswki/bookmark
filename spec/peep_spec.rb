require 'spec_helper'

describe Peep do
	context 'testing out datamapper' do
		it 'should be created and then retrived from the db' do
			expect(Peep.count).to eq 0
			Peep.create(message: "bob")
			expect(Peep.count).to eq 1
			peep = Peep.first
			expect(peep.message).to eq message: "bob"
			peep.destroy
			expect(Peep.count).to eq 0
		end
	end
end