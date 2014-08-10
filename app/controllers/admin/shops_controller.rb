class Admin::ShopsController < Admin::ApplicationController

  before_filter :set_shop, only: [:show, :edit, :update, :destroy]

  def index
    @shops = Shop.all
  end

  def show
  end

  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(shop_params)
    if @shop.save
      flash[:success] = I18n.t('admin.flashes.successfully_created')
      redirect_to admin_shops_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @shop.update(shop_params)
      flash[:success] = I18n.t('admin.flashes.successfully_updated')
      redirect_to admin_shops_url
    else
      render :edit
    end
  end

  def destroy
    @shop.destroy
    flash[:info] = I18n.t('admin.flashes.successfully_destroy')
    redirect_to admin_shops_url
  end

  private

    def set_shop
      @shop = Shop.find(params[:id])
    end

    def shop_params
      params.require(:shop).permit(:name, :address, :tel, :menu)
    end

end
