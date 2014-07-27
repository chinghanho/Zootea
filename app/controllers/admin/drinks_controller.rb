class Admin::DrinksController < Admin::ApplicationController

  before_filter :set_shop, only: [:index, :new, :create, :edit, :destroy]
  before_filter :set_drink, only: [:edit, :destroy]

  def index
  end

  def new
    @drink = Drink.new
  end

  def create
    @drink = @shop.drinks.new(drink_params)
    if @drink.save
      flash[:success] = I18n.t('admin.flashes.successfully_created')
      redirect_to admin_shop_url(@shop)
    else
      render :new
    end
  end

  def edit
  end

  def destroy
    @drink.destroy
    flash[:info] = I18n.t('admin.flashes.successfully_destroy')
    redirect_to admin_shop_url(@shop.id)
  end

  private

    def set_shop
      @shop = Shop.find(params[:shop_id])
    end

    def set_drink
      @drink = Drink.find(params[:id])
    end

    def drink_params
      params.require(:drink).permit(:shop_id, :name,
        :small_size_price,:medium_size_price, :large_size_price)
    end

end
