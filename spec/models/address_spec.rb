require 'rails_helper'
describe Profile do
  describe '#create_address' do

    it "郵便番号が空だった場合" do
      address = build(:address, post_code: "")
      address.valid?
      expect(address.errors[:post_code]).to include("を入力してください")
    end

    it "都道府県が空だった場合" do
      address = build(:address, prefecture: "")
      address.valid?
      expect(address.errors[:prefecture]).to include("を入力してください")
    end

    it "市区町村が空だった場合" do
      address = build(:address, city: "")
      address.valid?
      expect(address.errors[:city]).to include("を入力してください")
    end

    it "番地が空だった場合" do
      address = build(:address, street_number: "")
      address.valid?
      expect(address.errors[:street_number]).to include("を入力してください")
    end

  end
end