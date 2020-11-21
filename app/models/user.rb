class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  with_options presence: true do 
    # string型は255文字以内制限が自動でかかってる
    # nicknameは255文字以内、平仮名カタカナ漢字を許可
    validates :nickname

    # emailは6文字以上255文字以下、文字@文字.文字、DBへの重複登録除外
    validates :email,           length: {minimum: 6},
                                format: {with: /\A\S+@\S+\.\S+\z/},
                                uniqueness: { case_sensitive: true }

    # パスワードは6文字以上255文字以下、英数字が入力されていることと、末尾が英数字（大文字小文字の判定はなし）
    validates :password,        length: {minimum: 6},
                                format: {with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i}

    # 下の名前は255文字以内、漢字と平仮名を許可
    # 苗字は255文字以内、漢字と平仮名を許可
    with_options format: {with: /\A[一-龥ぁ-ん]/} do
      validates :firstname
      validates :lastname
    end

    # 下の名前（カタカナ）は255文字以内、カタカナを許可
    # 苗字（カタカナ）は255文字以内、カタカナを許可
    with_options format: {with: /\A[ァ-ヶー－]+\z/} do
      validates :firstname_kana
      validates :lastname_kana
    end
  end
    # 生年月日はyyyy-mm-dd形式
    validates :birthday,        format:{with: /\A\d{4}[-]\d{2}[-]\d{2}\z/}

end


 

  # DB(に登録されているのはtanaka)
  # tanaka 

  # iがあるとTANAKAは登録できるTanakaも登録できる、ない場合はTANAKAもTanakaもは登録できない

  

