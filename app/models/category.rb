class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: 'レディース' },
    { id: 3, name: 'メンズ' },
    { id: 4, name: 'ベビー・キッズ' },
    { id: 5, name: 'インテリア・住まい・小物' },
    { id: 6, name: '本・音楽・ゲーム' },
    { id: 7, name: 'おもちゃ・ホビー・グッズ' },
    { id: 8, name: '家電・スマホ・カメラ' },
    { id: 9, name: 'スポーツ・レジャー' },
    { id: 10, name: 'ハンドメイド' },
    { id: 11, name: 'その他' }
  ]
  include ActiveHash::Associations
  has_many :items
end


  # class Category < ApplicationRecord
  # この「<」は継承を意味する
# ApplicationRecordを継承するということは、普通のモデルファイルを参照するということ（ApplicationRecordクラスを継承している）
# DBを作るし、参照するし、使う（これが普通）
# 通常はDBがないとここでエラーが起こる。ActiveHash::Baseの記述にすると、怒られない

# class Category < ActiveHash::Base
# これだと、普通じゃないモデルファイル（ActiveHash::Baseクラス）を継承している
# つまり、ActiveHashクラスを継承するということはDBを作らないし使わないし参照しない、ということ
