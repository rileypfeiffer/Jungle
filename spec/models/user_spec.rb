require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'validates when all four properties are valid' do
      @user = User.new(name: 'Riley', email: 'riley.p@gmail.com', password: 'jungle', password_confirmation: 'jungle')

      expect(@user).to be_valid
    end
    it 'should not validate when no name exists' do
      @user = User.new(name: nil, email: 'riley.p@gmail.com', password: 'jungle', password_confirmation: 'jungle')

      expect(@user).to_not be_valid
    end
    it 'should not validate if no email exists' do
      @user = User.new(name: 'Riley', email: nil, password: 'jungle', password_confirmation: 'jungle')

      expect(@user).to_not be_valid
    end
    it 'should not validate if password is shorter than four characters' do
      @user = User.new(name: 'Riley', email: 'riley.p@gmail.com', password: 'ju', password_confirmation: 'ju')

      expect(@user).to_not be_valid
    end
    it 'should not validate if password does not match password confirmation' do
      @user = User.new(name: 'Riley', email: 'riley.p@gmail.com', password: 'jungle1', password_confirmation: 'jungle2')

      expect(@user).to_not be_valid
    end
    it 'should not validate if provided email already exists in database' do
      @user1 = User.create(name: 'Riley', email: 'riley.p@gmail.com', password: 'jungle', password_confirmation: 'jungle')
      @user2 = User.create(name: 'Jon', email: 'riley.p@gmail.com', password: 'jungle1', password_confirmation: 'jungle1')

      expect(@user2).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should authenticate a valid user' do
      @user = User.create(name: 'Riley', email: 'riley.p@gmail.com', password: 'jungle', password_confirmation: 'jungle')

      expect(User.authenticate_with_credentials(@user.email, @user.password)).to eq(@user)
    end
    it 'should not authenticate when an incorrect email is provided' do
      @user = User.create(name: 'Riley', email: 'riley.p@gmail.com', password: 'jungle', password_confirmation: 'jungle')

      expect(User.authenticate_with_credentials('riley@gmail.com', @user.password)).to_not eq(@user)
    end
    it 'should not authenticate when an incorrect password is provided' do
      @user = User.create(name: 'Riley', email: 'riley.p@gmail.com', password: 'jungle', password_confirmation: 'jungle')

      expect(User.authenticate_with_credentials(@user.email, 'jugnle')).to_not eq(@user)
    end
    it 'should authenticate when leading and/or trailing spaces exist in email field' do
      @user = User.create(name: 'Riley', email: 'riley.p@gmail.com', password: 'jungle', password_confirmation: 'jungle')

      expect(User.authenticate_with_credentials('   riley.p@gmail.com  ', @user.password)).to eq(@user)
    end
    it 'should authenticate when the text case of email provided does not match' do
      @user = User.create(name: 'Riley', email: 'riley.p@gmail.com', password: 'jungle', password_confirmation: 'jungle')

      expect(User.authenticate_with_credentials('rILeY.P@gmail.com', @user.password)).to eq(@user)
    end
  end
end
