class CheckoutController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = session[:cart] || {}
    if @cart.empty?
      redirect_to cart_path, alert: 'Your cart is empty!'
      return
    end
    @cart_items = []
    @subtotal = 0
    @cart.each do |product_id, quantity|
      product = Product.find_by(id: product_id)
      next unless product

      price = product.on_sale && product.sale_price ? product.sale_price : product.current_price
      line_total = price * quantity
      @subtotal += line_total
      @cart_items << { product: product, quantity: quantity, price: price, line_total: line_total }
    end
    @provinces = Province.order(:name)
    @tax = @subtotal * 0.05
    @total = @subtotal + @tax
  end

  def create
    @cart = session[:cart] || {}
    if @cart.empty?
      redirect_to cart_path, alert: 'Your cart is empty!'
      return
    end
    @subtotal = 0
    @cart.each do |product_id, quantity|
      product = Product.find_by(id: product_id)
      if product
        price = product.on_sale && product.sale_price ? product.sale_price : product.current_price
        @subtotal += price * quantity
      end
    end
    province = Province.find_by(id: params[:province_id])
    tax_rate = province ? (province.gst + province.pst + province.hst) / 100.0 : 0.05
    tax = @subtotal * tax_rate
    total = @subtotal + tax
    order = Order.create!(
      user: current_user,
      status: 'pending',
      subtotal: @subtotal,
      tax: tax,
      total: total
    )
    @cart.each do |product_id, quantity|
      product = Product.find_by(id: product_id)
      next unless product

      price = product.on_sale && product.sale_price ? product.sale_price : product.current_price
      OrderItem.create!(
        order: order,
        product: product,
        quantity: quantity,
        unit_price: price,
        line_total: price * quantity
      )
    end
    session[:cart] = {}
    flash[:notice] = "Order ##{order.id} placed successfully!"
    redirect_to order_path(order)
  end
end
