require 'rails_helper'
RSpec.describe ItemUser, type: :model do
  describe '商品購入' do
    before do
      user = FactoryBot.create(:user)
      @itemuser = FactoryBot.build(:item_user,user_id: user.id)
    end

    context '商品購入成功（正常系）' do
      it "新規登録データが正常に入っていること" do
        expect(@itemuser).to be_valid
      end
    end

    context '商品購入失敗（異常系）' do
      # --------user_id--------
      it "user_idが空白であること" do
        @itemuser.user_id = ""
        @itemuser.valid?
        expect(@itemuser.errors.full_messages).to include("User can't be blank")
      end

      it "user_idが数値以外であること" do
        @itemuser.user_id = "a"
        @itemuser.valid?
        expect(@itemuser.errors.full_messages).to include("User is invalid")
      end
      
      # --------item_id--------
      it "item_idが空白であること" do
        @itemuser.item_id = ""
        @itemuser.valid?
        expect(@itemuser.errors.full_messages).to include("Item can't be blank")
      end

      it "item_idが数値以外であること" do
        @itemuser.item_id = "a"
        @itemuser.valid?
        expect(@itemuser.errors.full_messages).to include("Item is invalid")
      end

      # --------郵便番号--------
      it "郵便番号が不適切なデータになっていること" do
        @itemuser.postcode = "11111111"
        @itemuser.valid?
        expect(@itemuser.errors.full_messages).to include("Postcode is invalid")
      end

      it "郵便番号が空白であること" do
        @itemuser.postcode = ""
        @itemuser.valid?
        expect(@itemuser.errors.full_messages).to include("Postcode can't be blank")
      end

      # --------市区町村--------
      it "市区町村が空白であること" do
        @itemuser.municipality = ""
        @itemuser.valid?
        expect(@itemuser.errors.full_messages).to include("Municipality can't be blank")
      end

      # --------番地--------
      it "番地が空白であること" do
        @itemuser.address = ""
        @itemuser.valid?
        expect(@itemuser.errors.full_messages).to include("Address can't be blank")
      end
      
      # --------電話番号--------
      it "電話番号が10または11桁の以外の数値であること" do
        @itemuser.phonenumber = "1234"
        @itemuser.valid?
        expect(@itemuser.errors.full_messages).to include("Phonenumber is invalid")
      end

      it "電話番号が空白であること" do
        @itemuser.phonenumber = ""
        @itemuser.valid?
        expect(@itemuser.errors.full_messages).to include("Phonenumber can't be blank")
      end

      # --------トークン--------
      it "トークンが空白であること" do
      @itemuser.token = ""
      @itemuser.valid?
      expect(@itemuser.errors.full_messages).to include("Token can't be blank")
    end

    end
  end
end