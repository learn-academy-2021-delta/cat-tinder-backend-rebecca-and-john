require 'rails_helper'

RSpec.describe Cat, type: :model do
    it 'should have a valid name' do 
        cat = Cat.create(age: 3, enjoys: 'all the attention')
        expect(cat.errors[:name]).to_not be_empty
    end

    it 'should have a valid age' do 
        cat = Cat.create(name: 'Toast', enjoys: 'all the attention')
        expect(cat.errors[:age]).to_not be_empty
    end

    it 'should have a valid enjoys' do 
        cat = Cat.create(name: 'Toast', age: 2)
        expect(cat.errors[:enjoys]).to_not be_empty
    end

    it 'should have an enjoys value of at least 10 characters' do
        cat = Cat.create(name: 'Toast', age: 2, enjoys: 'eating')
        expect(cat.errors[:enjoys]).to_not be_empty
    end
end
