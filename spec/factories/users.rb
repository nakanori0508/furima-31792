FactoryBot.define do
  factory :user do
    nickname              {"テストテスト"}
    email                 {"test@example.com"}
    password              {"aaa111"}
    password_confirmation {password}
    firstname             {"名前てすと"}
    lastname              {"苗字てすと"}
    firstname_kana        {"ナマエテスト"}
    lastname_kana         {"ミョウジテスト"}
    birthday              {"1950-11-10"}
  end
end


# nicknameは255文字以内、平仮名カタカナ漢字を許可
# emailは6文字以上255文字以下、文字@文字.文字
 # パスワードは6文字以上1024文字以下、英数字が入力されていることと、末尾が英数字（大文字小文字の判定はなし）
 # 下の名前は255文字以内、漢字と平仮名を許可
 # 苗字は255文字以内、漢字と平仮名を許可
 # 下の名前（カタカナ）は255文字以内、カタカナを許可
 # 苗字（カタカナ）は255文字以内、カタカナを許可
 # 生年月日はyyyy-mm-dd形式