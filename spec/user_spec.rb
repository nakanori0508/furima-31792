require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end


    context '新規登録がうまくいくとき（正常系）' do
      it "新規登録データが正常に入っていること" do
        # be_validは正常系の時しか使わない
        # be_validは正しくデータが保存されているか確認する
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかない時（異常系）'do

      # -----nicknameの異常系-----
      # valid?はバリデーションが正しくかかっているか確認する。正常系では使わない。
      it "nicknameが空のため登録できないこと" do
        @user.nickname = ""
        @user.valid?
        # eqを使う場合は計算結果のみ。数値の一致を確認する
        # includeを使うのは、@user.errors.full_messagesの出力結果が配列であり、配列内に指定した値があるか確認するため
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      # -----emailの異常系-----
      it "emailが空のため登録できないこと" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it "emailの値が@無しのため登録できないこと" do
        @user.email = "testexample.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it "emailの値が.無しのため登録できないこと" do
        @user.email = "test@examplecom"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it "emailの値が@と.があるが6文字未満のため登録できないこと" do
        @user.email = "t@c.c"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is too short (minimum is 6 characters)")
      end
      
      it "すでに登録済みのemailで登録しようとしても登録できないこと" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end

      # -----passwordの異常系-----
      it "passwordが空のため登録できないこと" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it "passwordが英字のみのため登録できないこと" do
        @user.password = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end

      it "passwordが数字のみのため登録できないこと" do
        @user.password = "12345678"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end

      it "passwordが6文字未満のため登録できないこと" do
        @user.password = "a1a1"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      
      # -----firstnameの異常系-----
      it "firstnameが空のため登録できないこと" do
        @user.firstname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Firstname can't be blank")
      end

      it "firstnameが平仮名と漢字以外の文字が使われているため登録できないこと" do
        @user.firstname = "aaaaa111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Firstname is invalid")
      end
      
      # -----lastnameの異常系-----
      it "lastnameが空のため登録できないこと" do
        @user.lastname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Lastname can't be blank")
      end

      it "lastnameが平仮名と漢字以外の文字が使われているため登録できないこと" do
        @user.lastname = "aaaaa111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Lastname is invalid")
      end

      # -----firstname_kanaの異常系-----
      it "firstname_kanaが空のため登録できないこと" do
        @user.firstname_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Firstname kana can't be blank")
      end

      it "firstname_kanaはカタカナ以外の文字が使われているため登録できないこと" do
        @user.firstname_kana = "aaaaa111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Firstname kana is invalid")
      end

      # lastname_kanaの異常系
      it "lastname_kanaが空のため登録できないこと" do
        @user.lastname_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Lastname kana can't be blank")
      end

      it "lastname_kanaはカタカナ以外の文字が使われているため登録できないこと" do
        @user.lastname_kana = "aaaaa111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Lastname kana is invalid")
      end

      # birthdayの異常系
      it "birthdayは数値のみでyyyy-MM-dd形式" do
        @user.birthday = "------"
        @user.valid?
      end

    end
end
end

# ターミナル上で「bundle exec rspec spec/usermanage.rb」コマンドを実行
# ターミナル上で「@user.errors.full_messages」コマンドを実行
# ["Firstname can't be blank", "Firstname is invalid", "Lastname is invalid"]という記述はエラーの内容（配列）

# ターミナル上でrails cコマンドを実行する。変数A = ""みたいに定義する。変数A.match(正規表現)
# 例：nickname.match(/\A[ぁ-んァ-ン一-龥])

      # 多分いらないけど、せっかく書いちゃったので記念に取っておきたい
      # it "nicknameに英文字が使われているため登録できないこと" do
      #   @user.nickname = "ラーメンaつけ麺"
      #   @user.valid?
      #   binding.pry
      #   expect(@user.errors.full_messages).to include("Nickname is invalid")
      # end

      # it "nicknameに数字が使われているため登録できないこと" do
      #   @user.nickname = "ラーメン111つけ麺"
      #   @user.valid?
      #   expect(@user.errors.full_messages).to include("Nickname is invalid")
      # end
      # it "nicknameに記号が使われているため登録できないこと" do
      #   @user.nickname = "ラーメン.?¥つけ麺"
      #   @user.valid?
      #   expect(@user.errors.full_messages).to include("Nickname is invalid")
      # end
