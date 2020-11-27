class ItemsController < ApplicationController
  # newアクションとcreateアクション実行時、未ログインユーザーは弾かれてログイン画面へ遷移する
  before_action :authenticate_user!,only:[:new,:create]
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
    @item = Item.find(params[:id])
  end
  
  def edit
    # ログインしていないユーザーが編集画面へアクセスすると、@itemやcurrent_userが存在しないためエラーになる。
    # それを防ぐため、あえて二段階ifを使用している
    if user_signed_in?
      @item = Item.find(params[:id])
      unless current_user.id == @item.user_id
        redirect_to action: :index
      end
    else
      redirect_to action: :index
    end
  end

  def update
    @item = Item.find(params[:id])
    if  @item.update(update_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  def destroy
  end

  private 
  def item_params
    # itemsテーブルにデータ保存を許可。user_idは入力必須だがparamsにはデータがないので、カレントユーザーのIDを引っ張ってくる
    params.require(:item).permit(:name, :explan, :category_id, :status_id, :shipfee_id, :prefecture_id, :dayship_id, :price, :image).merge(user_id: current_user.id)
  end

  def update_params
    params.require(:item).permit(:name, :explan, :category_id, :status_id, :shipfee_id, :prefecture_id, :dayship_id, :price, :image)
  end


end
