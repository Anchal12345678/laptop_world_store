class ProductsController < ApplicationController
  def index
    @products = Product.all
    @categories = Category.all
    @products = @products.where(category_id: params[:category_id]) if params[:category_id].present?
    if params[:search].present?
      @products = @products.where('name LIKE ? OR description LIKE ?',
                                  "%#{params[:search]}%",
                                  "%#{params[:search]}%")
    end
    if params[:filter] == 'on_sale'
      @products = @products.where(on_sale: true)
    elsif params[:filter] == 'new'
      @products = @products.where(created_at: 3.days.ago..)
    end
    @products = @products.page(params[:page]).per(12)
  end

  def show
    @product = Product.find(params[:id])
  end
end
