class ItemUser 
  include ActiveModel::Model
  attr_accessor :user_id,:item_id,:postcode,:prefecture_id,:municipality,:address,:buildingname,:phonenumber,:buyer_id,:token

  with_options presence: true do
    validates :postcode,         format: {with: /\A\d{3}[-]\d{4}\z/}
    validates :municipality
    validates :address
    # validates :buildingname 必須じゃないから
    validates :phonenumber,      format: {with: /\A\d{10,11}\z/}
    validates :token
    validates :user_id,      format: {with: /\A[0-9]+\z/}
    validates :item_id,      format: {with: /\A[0-9]+\z/}
  end

  def save
    buyer = Buyer.create(user_id: user_id,item_id: item_id)
    Purchase.create(postcode: postcode,prefecture_id: prefecture_id,municipality: municipality,address: address,buildingname: buildingname,phonenumber: phonenumber,buyer_id: buyer.id)
  end
  
end