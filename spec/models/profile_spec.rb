require 'rails_helper'
describe Profile do
  describe '#create_profile' do

    it "苗字の入力が空だった場合" do
      profile = build(:profile, family_name: "")
      profile.valid?
      expect(profile.errors[:family_name]).to include("を入力してください")
    end

    it "名前の入力が空だった場合" do
      profile = build(:profile, first_name: "")
      profile.valid?
      expect(profile.errors[:first_name]).to include("を入力してください")
    end

    it "苗字(振り仮名)の入力が空だった場合" do
      profile = build(:profile, family_name_kana: "")
      profile.valid?
      expect(profile.errors[:family_name_kana]).to include("を入力してください")
    end

    it "名前(振り仮名)の入力が空だった場合" do
      profile = build(:profile, first_name_kana: "")
      profile.valid?
      expect(profile.errors[:first_name_kana]).to include("を入力してください")
    end

    it "苗字(振り仮名)の入力が平仮名だった場合" do
      profile = build(:profile, family_name_kana: "たなか")
      profile.valid?
      expect(profile.errors[:family_name_kana]).to include("は不正な値です")
    end

    it "名前(振り仮名)の入力が平仮名だった場合" do
      profile = build(:profile, first_name_kana: "たろう")
      profile.valid?
      expect(profile.errors[:first_name_kana]).to include("は不正な値です")
    end

    it "誕生日がnilだった場合" do
      profile = build(:profile, birth_day: "")
      profile.valid?
      expect(profile.errors[:birth_day]).to include("を入力してください")
    end

    it "mobileが桁数不足だった場合" do
      profile = build(:profile, mobile: "111111")
      profile.valid?
      expect(profile.errors[:mobile]).to include("は不正な値です")
    end

  end
end