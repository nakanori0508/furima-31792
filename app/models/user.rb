class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  with_options presence: true do 
    # nicknameは255文字以内、平仮名カタカナ漢字を許可
    validates :nickname,        length: {maximum: 255}
                                # format: {with: /\A[ぁ-んァ-ン一-龥]+\z/}

    # emailは6文字以上255文字以下、文字@文字.文字
    validates :email,           length: {minimum: 6, maximum: 255},
                                format: {with: /\A\S+@\S+\.\S+\z/}

    # パスワードは6文字以上1024文字以下、英数字が入力されていることと、末尾が英数字（大文字小文字の判定はなし）
    validates :password,        length: {minimum: 6,maximum: 1024},
                                format: {with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i}

    # 下の名前は255文字以内、漢字と平仮名を許可
    validates :firstname,       length: {maximum: 255},
                                format: {with: /\A[一-龥ぁ-ん]+\z/}

    # 苗字は255文字以内、漢字と平仮名を許可
    validates :lastname,        length: {maximum: 255},
                                format: {with: /\A[一-龥ぁ-ん]+\z/}

    # 下の名前（カタカナ）は255文字以内、カタカナを許可
    validates :firstname_kana,  length: {maximum: 255},
                                format: {with: /\A[ァ-ヶー－]+\z/}

    # 苗字（カタカナ）は255文字以内、カタカナを許可
    validates :lastname_kana,   length: {maximum: 255},
                                format: {with: /\A[ァ-ヶー－]+\z/}
  end
    # 生年月日はyyyy-mm-dd形式
    validates :birthday,        format:{with: /\A\d{4}[-]\d{2}[-]\d{2}\z/}

end



  # この記述はやめておいた方がいいかしら？
  # with_options length: {maximum: 255},format: {with: /\A[一-龥ぁ-ん]/} do
  #   validates :firstname
  #   validates :lastname
  # end

  # DB(に登録されているのはtanaka)
  # tanaka 

  # iがあるとTANAKAは登録できるTanakaも登録できる、ない場合はTANAKAもTanakaもは登録できない

  
