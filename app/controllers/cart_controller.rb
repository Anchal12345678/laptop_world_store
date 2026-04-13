class CartController < ApplicationController
  def show
    @cart = session[:cart] || {}
    @cart_items = []
    @total = 0
    @cart.each do |product_id, quantity|
      product = Product.find_by(id: product_id)
      next unless product

      price = product.on_sale && product.sale_price ? product.sale_price : product.current_price
      line_total = price * quantity
      @total += line_total
      @cart_items << { product: product, quantity: quantity, price: price, line_total: line_total }
    end
  end

  def add
    @product = Product.find(params[:id])
    session[:cart] ||= {}
    session[:cart][@product.id.to_s] ||= 0
    session[:cart][@product.id.to_s] += 1
    flash[:notice] = "#{@product.name} added to cart!"
    redirect_to products_path
  end

  def update
    session[:cart] ||= {}
    if params[:quantity].to_i.positive?
      session[:cart][params[:id]] = params[:quantity].to_i
    else
      session[:cart].delete(params[:id])
    end
    redirect_to cart_path
  end

  def remove
    session[:cart] ||= {}
    session[:cart].delete(params[:id])
    flash[:notice] = 'Item removed from cart'
    redirect_to cart_path
  end
end
