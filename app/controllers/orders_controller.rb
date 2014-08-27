class OrdersController < ApplicationController
  before_filter :set_group, only: [:new, :create]


  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = @group.orders.new
  end

  def create
    drink = @group.shop.drinks.find_or_create_by(name: order_params[:drink][:name])

    @order       = @group.orders.new
    @order.user  = current_user
    @order.drink = drink
    @order.price = order_params[:price]
    @order.description = order_params[:description]

    if !current_user_joined_group && @order.save
      flash[:success] = I18n.t('orders.flashes.order_created_successfully')
      redirect_to root_url
    else
      render :new
    end
  end

  private

    def set_group
      @group = Group.find(params[:group_id])
    end

    def order_params
      params.require(:order).permit(:price, :description, drink: [:name])
    end

    def current_user_joined_group
      @group.users.include? current_user
    end

end
