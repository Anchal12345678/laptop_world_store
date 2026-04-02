class AddressesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
    @provinces = Province.order(:name)
  end

  def update
    @user = current_user
    @provinces = Province.order(:name)
    if @user.update(address_params)
      flash[:notice] = "Address saved successfully!"
      redirect_to root_path
    else
      flash[:alert] = "Could not save address!"
      render :edit
    end
  end

  private

  def address_params
    params.require(:user).permit(:street_address, :city,
                                  :postal_code, :province_id)
  end
end
