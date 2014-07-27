class OrdersController < ApplicationController
  before_filter :set_group, only: :create


  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = @group.orders.new
    @order.user = current_user
    @order.drink = Drink.find(order_params[:drink])
    @order.size = order_params[:size]
    if @order.save
      flash[:success] = I18n.t('orders.flashes.order_created_successfully')
      redirect_to root_url
    else
      render :show
    end
  end

  private

    def set_group
      @group = Group.find(params[:group_id])
    end

    def order_params
      params.require(:order).permit(:drink, :size)
    end

end
