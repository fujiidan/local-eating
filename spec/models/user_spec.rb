require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    it '全ての情報を適切に入力すれば新規登録できること' do
      expect(@user).to be_valid
    end

    it 'ニックネームが必須であること' do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include('ニックネームを入力してください')
    end

    it 'ニックネームは一意性であること' do
      @user.nickname = 'テストタロウ'
      @user.save
      another_user = FactoryBot.build(:user, nickname: @user.nickname)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('ニックネームはすでに存在します')
    end  

    it 'メールアドレスが必須であること' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include('Eメールを入力してください')
    end

    it 'メールアドレスが一意性であること' do
      @user.email = 'aaa@aaa'
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
    end

    it 'メールアドレスは、@を含む必要があること' do
      @user.email = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include('Eメールは不正な値です')
    end

    it 'パスワードが必須であること' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードを入力してください')
    end

    it 'パスワードは、6文字以上での入力が必須であること' do
      @user.password = 'abc12'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
    end

    it 'パスワードは、数字のみでは保存できないこと' do
      @user.password = '123456'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは半角英数字をそれぞれ１文字以上含めてください')
    end

    it 'パスワードは、英字のみでは保存できないこと' do
      @user.password = 'abcdef'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは半角英数字をそれぞれ１文字以上含めてください')
    end

    it 'パスワードは、全角文字では保存できないこと' do
      @user.password = '１２３ABC'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは半角英数字をそれぞれ１文字以上含めてください')
    end

    it 'パスワードとパスワード（確認用）、値の一致が必須であること' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
    end
  end
end
