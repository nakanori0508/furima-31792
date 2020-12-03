class OrdersController < ApplicationController
  before_action :authenticate_user!,only:[:index]
  before_action :get_params,only:[:index,:create]

  def index
    if current_user.id == @item.user.id || @item.buyer != nil
      redirect_to root_path
    end
    # ルーティングにordersコントローラーをitemsコントローラーにネストしているので、
    # ordersコントローラーでitemsのidを引っ張ってくる時の表記は「:item_id」と表記する
    # @item = Item.find(params[:item_id])
    @itemuser = ItemUser.new
  end

  def create
    @itemuser = ItemUser.new(purchase_params)
    if  @itemuser.valid?
       pay_item
       @itemuser.save
       redirect_to root_path
    else
       
       render :index
    end
   
  end

  private
  def purchase_params
    params.require(:item_user).permit(:postcode,:prefecture_id,:municipality,:address,:buildingname,:phonenumber,:buyer_id)
    .merge(user_id: current_user.id, item_id: params[:item_id],token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
    amount: @item.price, #purchase_params[:price],   商品の値段
    card: purchase_params[:token],    # カードトークン
    currency: 'jpy'                 # 通貨の種類（日本円）
  )
  end

  def get_params
    @item = Item.find(params[:item_id])
  end
end
