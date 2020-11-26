class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :prefecture
    belongs_to :category
    belongs_to :status
    belongs_to :shipfee
  
    #ジャンルの選択が「--」の時は保存できないようにする
    with_options numericality: { other_than: 1 } do
      validates :prefecture_id
      validates :category_id
      validates :status_id
      validates :shipfee_id
      validates :dayship_id
    end
    with_options presence: true do
      validates :image
      validates :name
      validates :explan
      validates :price
    end
    # 9_999_999の_はカンマの代わり。見やすくするためだけに入れてる。なくてもいい？300から999万9999まで許可
    validates_inclusion_of :price, in: 300..9_999_999
end
