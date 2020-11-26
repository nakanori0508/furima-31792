require 'rails_helper'
RSpec.describe Item, type: :model do
  describe '商品投稿' do
    before do
      @item = FactoryBot.build(:item)
      # fixture_file_upload('public/images/sample1のコピー.jpg','sample1のコピー.jpg')
      # これはこれでうまくいくのか、rails_helper.rbやspec_helper.rbをいじらないとうまくいかないのかもわからない
    end

    context '商品投稿がうまくいくとき（正常系）' do
      it "新規登録データが正常に入っていること" do
        expect(@item).to be_valid
      end
    end

    context '商品投稿がうまくいかない時（異常系）' do
      it '画像が選択されていないこと' do
        # @item.imageにはファイルパスが本来入っている。””にしてしまうと、””というファイルパスを探しに行って、そんなファイルパス入らねーとActiveStorageが怒る
        # @item.imageに空を作りたいなら「nil」（""はつけない）という記述にする
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
        
      end

      it '商品名が空欄であること' do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it '商品説明が空欄であること' do
        @item.explan = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Explan can't be blank")
      end

      it 'カテゴリーが選択されていないこと' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end

      it '商品の状態が選択されていないこと' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Status must be other than 1")
      end

      it '配送料の負担が選択されていないこと' do
        @item.shipfee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipfee must be other than 1")
      end

      it '発送元の地域が選択されていないこと' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be other than 1")
      end

      it '発送までの日数が選択されていないこと' do
        @item.dayship_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Dayship must be other than 1")
      end

      it '価格が入力されていないこと' do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not included in the list")
      end

      it '価格が範囲外の数値が入力されていること' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not included in the list")
      end
    end
  end
end