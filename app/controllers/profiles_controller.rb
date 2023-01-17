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
    if @user.update_columns(user_params)
      redirect_to profile_path, notice: "Perfil actualizado correctamente"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :avatar)
  end

end
