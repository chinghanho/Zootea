class Admin::GroupsController < Admin::ApplicationController

  def index
    @groups = Group.all
  end

  def edit
  end

end
