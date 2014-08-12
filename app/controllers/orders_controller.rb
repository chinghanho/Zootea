class OrdersController < ApplicationController
  before_filter :set_group, only: :create


  def show
    @order = Order.find(params[:id])
  end

  def create
    drink = Drink.find_by(name: order_params[:drink])
    if drink.nil?
      shop = @group.shop
      drink = shop.drinks.create(name: order_params[:drink])
    end

    order       = @group.orders.new
    order.user  = current_user
    order.drink = drink
    order.price = order_params[:price]
    order.save
    flash[:success] = I18n.t('orders.flashes.order_created_successfully')
    redirect_to root_url

    # fallback
    # !current_user_joined_group && order.save
  end

  private

    def set_group
      @group = Group.find(params[:group_id])
    end

    def order_params
      params.require(:order).permit(:drink, :price, :description)
    end

    def current_user_joined_group
      @group.users.include? current_user
    end

end
