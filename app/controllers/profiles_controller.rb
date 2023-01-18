class ProfilesController < ApplicationController

  def show
    @user = Current.user
    @products = @user.products
    @favorite_products = FindProducts.new.call(favorite: true).load_async
  end

  def edit
    @user = Current.user
  end

  def update
    @user = Current.user    
    if @user.update(user_params)
      redirect_to profile_path, notice: 'Profile updated successfully'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :avatar)
  end

end
