require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
  
    it 'valid user' do
      @user = User.new(email: 'test@mail.com', first_name: 'Ty', last_name: 'Honda', password: 'aaa', password_confirmation: 'aaa')
      expect(@user).to be_valid
    end

    it 'not valid without first name' do
      @user = User.new(email: 'test@mail.com', last_name: 'Honda', password: 'aaa', password_confirmation: 'aaa')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages[0]).to match(/First name can't be blank/)
    end

    it 'not valid without last name' do
      @user = User.new(email: 'test@mail.com', first_name: 'Ty', password: 'aaa', password_confirmation: 'aaa')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages[0]).to match(/Last name can't be blank/)
    end

    it 'not valid without email' do
      @user = User.new(first_name: 'Ty', last_name: 'Honda', password: 'aaa', password_confirmation: 'aaa')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages[0]).to match(/Email can't be blank/)
    end

    it 'password and password confirmation must match' do
      @user = User.new(email: 'test@mail.com', first_name: 'Ty', last_name: 'Honda', password: 'aaa', password_confirmation: 'abc')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages[0]).to match(/Password confirmation doesn't match Password/)
    end

    it 'valide when password and password confirmation match' do
      @user = User.new(email: 'test@mail.com', first_name: 'Ty', last_name: 'Honda', password: 'aaa', password_confirmation: 'aaa')
      expect(@user).to be_valid
    end

    it 'not valide when password is less than 3 characters' do
      @user = User.new(email: 'test@mail.com', first_name: 'Ty', last_name: 'Honda', password: 'aa', password_confirmation: 'aa')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages[0]).to eql("Password is too short (minimum is 3 characters)")
    end

    it 'email must be unique' do
      @user_1 = User.new(email: 'test@mail.com', first_name: 'Ty', last_name: 'Honda', password: 'aaa', password_confirmation: 'aaa')
      @user_1.save
      @user_2 = User.new(email: 'test@mail.com', first_name: 'Ty', last_name: 'Honda', password: 'aaa', password_confirmation: 'aaa')
      @user_2.save
      expect(@user_2).to_not be_valid
      expect(@user_2.errors.full_messages[0]).to match(/Email must be unique/)
    end

    it 'email must be unique that case is not sensitive' do
      @user_1 = User.new(email: 'test@mail.com', first_name: 'Ty', last_name: 'Honda', password: 'aaa', password_confirmation: 'aaa')
      @user_1.save
      @user_3 = User.new(email: 'TEST@mail.com', first_name: 'Ty', last_name: 'Honda', password: 'aaa', password_confirmation: 'aaa')
      expect(@user_3).to_not be_valid
      expect(@user_3.errors.full_messages[0]).to match(/Email must be unique/)
    end

  end

  describe '.authenticate_with_credentials' do
  
    it 'is valid' do
      @user_1 = User.new(email: 'test@mail.com', first_name: 'Ty', last_name: 'Honda', password: 'aaa', password_confirmation: 'aaa')
      @user_1.save
      @user = User.authenticate_with_credentials('test@mail.com', 'aaa')
      expect(@user).to_not be nil
    end

    it 'not valid if email is not correct' do
      @user_1 = User.new(email: 'test@mail.com', first_name: 'Ty', last_name: 'Honda', password: 'aaa', password_confirmation: 'aaa')
      @user_1.save
      @user = User.authenticate_with_credentials('tesssssst@mail.com', 'aaa')
      expect(@user).to be nil
    end

    it 'not valid if password is not correct' do
      @user_1 = User.new(email: 'test@mail.com', first_name: 'Ty', last_name: 'Honda', password: 'aaa', password_confirmation: 'aaa')
      @user_1.save
      @user = User.authenticate_with_credentials('test@mail.com', 'aaaaaaaaaa')
      expect(@user).to be nil
    end

    it 'few spaces before and/or after email address should be successful' do
      @user_1 = User.new(email: 'test@mail.com', first_name: 'Ty', last_name: 'Honda', password: 'aaa', password_confirmation: 'aaa')
      @user_1.save
      @user = User.authenticate_with_credentials('  test@mail.com  ', 'aaa')
      expect(@user).to_not be nil
    end

    it 'should be successful if email is in wrong case' do
      @user_1 = User.new(email: 'test@mail.com', first_name: 'Ty', last_name: 'Honda', password: 'aaa', password_confirmation: 'aaa')
      @user_1.save
      @user = User.authenticate_with_credentials('TesT@mail.com', 'aaa')
      expect(@user).to_not be nil
    end

  end

end
