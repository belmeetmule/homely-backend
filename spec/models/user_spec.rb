require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = User.new(full_name: 'Oshie', email: 'oshie@homely.com', password: 'password')
  end

  context 'Testing Validations' do
    it 'is valid with valid attributes' do
      @user.save
      expect(@user).to be_valid
    end

    it 'is not valid without a name' do
      @user.full_name = nil
      @user.save
      expect(@user).to_not be_valid
    end

    it 'is not valid without email' do
      @user.email = nil
      @user.save
      expect(@user).to_not be_valid
    end

    it 'is not valid without password' do
      @user.password = nil
      @user.save
      expect(@user).to_not be_valid
    end
  end

  context 'Testing Associations' do
    it 'has_many reservations' do
      assoc = User.reflect_on_association(:reservations)
      expect(assoc.macro).to eq :has_many
    end

    it 'has_many houses through reservations' do
      assoc = User.reflect_on_association(:houses)
      expect(assoc.macro).to eq :has_many
    end
  end
end