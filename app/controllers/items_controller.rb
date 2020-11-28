class ItemsController < ApplicationController
  # newアクションとcreateアクション実行時、未ログインユーザーは弾かれてログイン画面へ遷移する
  # authenticate_user!はログインしているかを確認する。user_signed_in?とほぼ同じ。
  # ただし、遷移先はauthenticate_user!はログインページ固定。それ以外の時はuser_signed_in?を使ったほうがいい
  before_action :authenticate_user!,only:[:new,:create,:edit]
  before_action :get_params,only:[:show,:update,:edit,:destroy]

  def index
    # N+1問題解決用。.allだと無駄な処理が出てしまう。
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    # ここをcreateにしてしまうと、すぐ下のifの@item.saveが意味をなさなくなるので、@itemにsave機能は付けたくないからnewにする
    @item = Item.new(item_params)
    
    # item.valid?はitem.rbのバリデーションをチェックする
    # @itemはItemというクラスのインスタンス変数なので、Itemのクラスが唯一存在するitem.rbを見にいく
    if @item.valid?
      # idは、（SQLの仕様で）この時点では作られていない。paramsにはid以外のユーザーが入力した情報が入っている
      # idが付与されるのは@item.saveが実行される時（DBへ登録される時）
      @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end
  
  def edit
    unless current_user.id == @item.user_id
      redirectIndex
    end
  end

  def update
    if  @item.update(update_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  def destroy
    if current_user.id == @item.user_id
      @item.destroy
    end
    redirectIndex
  end

  private 
  def item_params
    # itemsテーブルにデータ保存を許可。user_idは入力必須だがparamsにはデータがないので、カレントユーザーのIDを引っ張ってくる
    params.require(:item).permit(:name, :explan, :category_id, :status_id, :shipfee_id, :prefecture_id, :dayship_id, :price, :image).merge(user_id: current_user.id)
  end

  def update_params
    params.require(:item).permit(:name, :explan, :category_id, :status_id, :shipfee_id, :prefecture_id, :dayship_id, :price, :image)
  end

  def redirectIndex
    redirect_to action: :index
  end

  def get_params
    @item = Item.find(params[:id])
  end

end
