require 'rails_helper'

RSpec.describe 'Houses', type: :model do
    subject {House.new(name:"Villa", city:"Osaka", image:"wwww.sample-image.com", appartment_fee:200.0, description:"near to the beach")}

    before {subject.save}

    it 'name should be present' do
        subject.name = nil
        expect(subject).to_not be_valid
    end

    it 'city should be present' do
        subject.city = nil
        expect(subject).to_not be_valid
    end
    it 'image link should be present' do
        subject.image = nil
        expect(subject).to_not be_valid
    end
    it 'appartment fee should be present' do
        subject.appartment_fee = nil
        expect(subject).to_not be_valid
    end
    it 'description should be present' do
        subject.description = nil
        expect(subject).to_not be_valid
    end

    it 'name should not be too short' do
        subject.name = 'a'
        expect(subject).to_not be_valid
    end
    it 'name should not be too long' do
        subject.name = 'a' * 30
        expect(subject).to_not be_valid
    end

    it 'city name should not be too short' do
        subject.city = 'a'
        expect(subject).to_not be_valid
    end
    it 'city name should not be too long' do
        subject.city = 'a' * 25
        expect(subject).to_not be_valid
    end


    it 'description should not be too short' do
        subject.description = 'a'
        expect(subject).to_not be_valid
    end
    it 'description should not be too long' do
        subject.city = 'a' * 300
        expect(subject).to_not be_valid
    end

    it 'appartment fee should allow valid values' do
        subject.appartment_fee = 100.0
        expect(subject).to_not be_valid
    end
end