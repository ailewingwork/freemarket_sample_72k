require 'rails_helper'
describe Ship do
  describe '#create_ship' do

    it "苗字の入力が空だった場合" do
      ship = build(:ship, shipping_family_name: "")
      ship.valid?
      expect(ship.errors[:shipping_family_name]).to include("を入力してください")
    end

    it "名前の入力が空だった場合" do
      ship = build(:ship, shipping_first_name: "")
      ship.valid?
      expect(ship.errors[:shipping_first_name]).to include("を入力してください")
    end

    it "苗字(振り仮名)の入力がカタカナ以外だった場合" do
      ship = build(:ship, shipping_family_name_kana: "ae")
      ship.valid?
      expect(ship.errors[:shipping_family_name_kana]).to include("は不正な値です")
    end

    it "苗字(振り仮名)の入力が空だった場合" do
      ship = build(:ship, shipping_family_name_kana: "")
      ship.valid?
      expect(ship.errors[:shipping_family_name_kana]).to include("は不正な値です")
    end

    it "名前(振り仮名)の入力がカタカナ以外だった場合" do
      ship = build(:ship, shipping_first_name_kana: "aefae")
      ship.valid?
      expect(ship.errors[:shipping_first_name_kana]).to include("は不正な値です")
    end

    it "苗字(振り仮名)の入力が平仮名だった場合" do
      ship = build(:ship, shipping_family_name_kana: "たなか")
      ship.valid?
      expect(ship.errors[:shipping_family_name_kana]).to include("は不正な値です")
    end

    it "名前(振り仮名)の入力が平仮名だった場合" do
      ship = build(:ship, shipping_first_name_kana: "たろう")
      ship.valid?
      expect(ship.errors[:shipping_first_name_kana]).to include("は不正な値です")
    end

    it "mobileが桁数不足だった場合" do
      ship = build(:ship, mobile: "111111")
      ship.valid?
      expect(ship.errors[:mobile]).to include("は不正な値です")
    end

  end
end