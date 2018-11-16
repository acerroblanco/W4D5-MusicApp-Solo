class UsersController < ApplicatonController

  def new
    @user = User.new
    render :new
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  # def edit
  #
  # end
end
