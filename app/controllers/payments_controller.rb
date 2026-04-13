class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def new
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
      @cart_items << { product: product, quantity: quantity,
                       price: price, line_total: line_total }
    end

    @provinces = Province.order(:name)
    @tax = @subtotal * 0.05
    @total = @subtotal + @tax
    @stripe_publishable_key = ENV.fetch('STRIPE_PUBLISHABLE_KEY', nil)
  end

  def create
    @cart = session[:cart] || {}
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
    total_in_cents = (total * 100).to_i

    begin
      charge = Stripe::Charge.create(
        amount: total_in_cents,
        currency: 'cad',
        source: params[:stripeToken],
        description: "Laptop World Store - #{current_user.email}"
      )

      order = Order.create!(
        user: current_user,
        status: 'paid',
        subtotal: @subtotal,
        tax: tax,
        total: total,
        stripe_payment_id: charge.id
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
      flash[:notice] = "Payment successful! Order ##{order.id} placed!"
      redirect_to order_path(order)
    rescue Stripe::CardError => e
      flash[:alert] = "Payment failed: #{e.message}"
      redirect_to new_payment_path
    end
  end
end
