require 'rails_helper'
describe User do
  describe '#create' do

    it "nicknameがない場合は登録できないこと" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    it "emailがない場合は登録できないこと" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "passwordがない場合は登録できないこと" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "passwordの文字数が足りていないこと" do
      user = build(:user, password: "11111")
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上で入力してください")
    end

    it "確認passwordが一致していない場合" do
      user = build(:user, password: "1111111",password_confirmation: "2111111")
      user = User.new(nickname: "nickname", email: "test@gmail.com", password: "1111111", password_confirmation: "2111111")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

  end
end