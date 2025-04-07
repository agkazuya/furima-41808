require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    it 'nicknameが空では登録できない' do
      user = User.new(nickname: '', email: 'test@example', password: '000000', password_confirmation: '000000', first_name: '田中',
                      last_name: '太郎', first_name_kana: 'タナカ', last_name_kana: 'タロウ', date_of_birth: '19901111')
      user.valid?
      expect(user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'emailが空では登録できない' do
      user = User.new(nickname: 'テスト', email: '', password: '000000', password_confirmation: '000000', first_name: '田中',
                      last_name: '太郎', first_name_kana: 'タナカ', last_name_kana: 'タロウ', date_of_birth: '19901111')
      user.valid?
      expect(user.errors.full_messages).to include("Email can't be blank")
    end
    it 'passwordが空では登録できない' do
      user = User.new(nickname: 'テスト', email: 'test@example', password: '', password_confirmation: '000000', first_name: '田中',
                      last_name: '太郎', first_name_kana: 'タナカ', last_name_kana: 'タロウ', date_of_birth: '19901111')
      user.valid?
      expect(user.errors.full_messages).to include("Password can't be blank", "Password confirmation doesn't match Password")
    end
    it 'first_nameが空では登録できない' do
      user = User.new(nickname: 'テスト', email: 'test@example', password: '000000', password_confirmation: '000000', first_name: '',
                      last_name: '太郎', first_name_kana: 'タナカ', last_name_kana: 'タロウ', date_of_birth: '19901111')
      user.valid?
      expect(user.errors.full_messages).to include("First name can't be blank", 'First name is invalid')
    end
    it 'last_nameが空では登録できない' do
      user = User.new(nickname: 'テスト', email: 'test@example', password: '000000', password_confirmation: '000000', first_name: '田中',
                      last_name: '', first_name_kana: 'タナカ', last_name_kana: 'タロウ', date_of_birth: '19901111')
      user.valid?
      expect(user.errors.full_messages).to include("Last name can't be blank", 'Last name is invalid')
    end
    it 'first_name_kanaが空では登録できない' do
      user = User.new(nickname: 'テスト', email: 'test@example', password: '000000', password_confirmation: '000000', first_name: '田中',
                      last_name: '太郎', first_name_kana: '', last_name_kana: 'タロウ', date_of_birth: '19901111')
      user.valid?
      expect(user.errors.full_messages).to include("First name kana can't be blank", 'First name kana is invalid')
    end
    it 'last_name_kanaが空では登録できない' do
      user = User.new(nickname: 'テスト', email: 'test@example', password: '000000', password_confirmation: '000000', first_name: '田中',
                      last_name: '太郎', first_name_kana: 'タナカ', last_name_kana: '', date_of_birth: '19901111')
      user.valid?
      expect(user.errors.full_messages).to include("Last name kana can't be blank", 'Last name kana is invalid')
    end
    it 'date_of_birthが空では登録できない' do
      user = User.new(nickname: 'テスト', email: 'test@example', password: '000000', password_confirmation: '000000', first_name: '田中',
                      last_name: '太郎', first_name_kana: 'タナカ', last_name_kana: 'タロウ', date_of_birth: '')
      user.valid?
      expect(user.errors.full_messages).to include("Date of birth can't be blank")
    end
    it '重複したemailが存在する場合は登録できない' do
      User.create!(email: 'duplicate@example.com', nickname: 'テスト', password: 'a000000', password_confirmation: 'a000000', first_name: '田中',
                   last_name: '太郎', first_name_kana: 'タナカ', last_name_kana: 'タロウ', date_of_birth: '19900101')
      user_with_duplicate_email = User.new(email: 'duplicate@example.com', nickname: 'テスト', password: 'a000000', password_confirmation: 'a000000', first_name: '田中',
                                           last_name: '太郎', first_name_kana: 'タナカ', last_name_kana: 'タロウ', date_of_birth: '19900101')
      expect(user_with_duplicate_email).to_not be_valid
      expect(user_with_duplicate_email.errors[:email]).to include('has already been taken')
    end
    it 'emailは@を含まないと登録できない' do
      user = User.new(email: 'sample.com', nickname: 'テスト', password: 'a000000', password_confirmation: 'a000000', first_name: '田中',
                      last_name: '太郎', first_name_kana: 'タナカ', last_name_kana: 'タロウ', date_of_birth: '19900101')
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include('is invalid')
    end
    it 'passwordは6文字以上でないと登録できない' do
      user = User.new(email: 'sample@sample.com', nickname: 'テスト', password: 'abcde', password_confirmation: 'abcde', first_name: '田中',
                      last_name: '太郎', first_name_kana: 'タナカ', last_name_kana: 'タロウ', date_of_birth: '19900101')
      expect(user).to_not be_valid
      expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
    end
    it 'passwordとpassword_confirmationが一致しなければ登録できない' do
      user = User.new(email: 'sample@sample.com', nickname: 'テスト', password: 'a000000', password_confirmation: 'b000000', first_name: '田中',
                      last_name: '太郎', first_name_kana: 'タナカ', last_name_kana: 'タロウ', date_of_birth: '19900101')
      expect(user).to_not be_valid
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
  end
end
