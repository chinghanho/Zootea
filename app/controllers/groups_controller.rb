class GroupsController < ApplicationController

  before_filter :set_group, only: [:show, :destroy]
  before_filter :required_login, only: [:new, :create, :destroy]

  def index
    @group = Group.ongoing.first
    @groups = Group.all
    @order = Order.new({size: Order::SIZE_TYPE.second})
    @drinks = @group && @group.shop.drinks
    render :show if !@group.nil?
  end

  def show
    @order = Order.new({size: Order::SIZE_TYPE.second})
    @drinks = @group && @group.shop.drinks
  end

  def new
    redirect_to root_url if group_already_ongoing
    @group = Group.new
    @shops = Shop.all
    @valid_times = hours_map
  end

  def create
    @shops = Shop.all
    @valid_times = hours_map

    time = hours_map[group_params[:deadline].to_i]
    deadline = Time.now + time
    shop_id = group_params[:shop]
    @group = current_user.groups.new({shop_id: shop_id, deadline: deadline})
    if !group_already_ongoing && @group.save
      flash[:success] = "開始揪團囉！飲料團將在 #{deadline.to_s(:time)} 收單，到時候請記得打電話喔！"
      redirect_to root_url
    else
      render :new
    end
  end

  def destroy
    @group.destroy
    redirect_to root_url
  end


  private

    def set_group
      @group = Group.find(params[:id])
    end

    def group_params
      params.require(:group).permit(:shop, :deadline)
    end

    def hours_map
      [1.hour, 2.hours, 3.hours, 4.hours, 6.hours, 8.hours]
    end

    def group_already_ongoing
      true if Group.ongoing.count == 1
    end

end
