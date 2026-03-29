ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    # Stats Row
    columns do
      column do
        panel "Total Products" do
          h2 Product.count, style: "font-size: 3rem; color: #0d6efd; text-align: center;"
          para "Products in store", style: "text-align: center; color: #6c757d;"
        end
      end
      column do
        panel "Total Orders" do
          h2 Order.count, style: "font-size: 3rem; color: #198754; text-align: center;"
          para "Orders placed", style: "text-align: center; color: #6c757d;"
        end
      end
      column do
        panel "Total Customers" do
          h2 User.count, style: "font-size: 3rem; color: #dc3545; text-align: center;"
          para "Registered users", style: "text-align: center; color: #6c757d;"
        end
      end
      column do
        panel "Total Revenue" do
          revenue = Order.sum(:total).round(2)
          h2 "$#{revenue}", style: "font-size: 3rem; color: #fd7e14; text-align: center;"
          para "Total sales", style: "text-align: center; color: #6c757d;"
        end
      end
    end

    # Recent Orders
    panel "Recent Orders" do
      table_for Order.order(created_at: :desc).limit(10).includes(:user) do
        column("Order #") { |o| link_to "##{o.id}", admin_order_path(o) }
        column("Customer") { |o| o.user&.email }
        column("Status") { |o| status_tag o.status }
        column("Total") { |o| number_to_currency(o.total) }
        column("Date") { |o| o.created_at.strftime("%B %d, %Y") }
        column("Action") { |o| link_to "Edit", edit_admin_order_path(o), class: "button" }
      end
    end

    # Products by Category
    panel "Products by Category" do
      table_for Category.all do
        column("Category") { |c| c.name }
        column("Products") { |c| c.products.count }
        column("Action") { |c| link_to "View", admin_category_path(c), class: "button" }
      end
    end

    # Low Stock Products
    panel "Low Stock Products (less than 5)" do
      low_stock = Product.where("stock_quantity < 5")
      if low_stock.any?
        table_for low_stock do
          column("Product") { |p| p.name }
          column("Stock") { |p| p.stock_quantity }
          column("Price") { |p| number_to_currency(p.current_price) }
          column("Action") { |p| link_to "Edit", edit_admin_product_path(p), class: "button" }
        end
      else
        para "All products are well stocked!", style: "color: green;"
      end
    end

    # Pending Orders
    panel "Pending Orders" do
      pending = Order.where(status: "pending").includes(:user)
      if pending.any?
        table_for pending do
          column("Order #") { |o| link_to "##{o.id}", admin_order_path(o) }
          column("Customer") { |o| o.user&.email }
          column("Total") { |o| number_to_currency(o.total) }
          column("Date") { |o| o.created_at.strftime("%B %d, %Y") }
          column("Action") { |o| link_to "Update", edit_admin_order_path(o), class: "button" }
        end
      else
        para "No pending orders!", style: "color: green;"
      end
    end
  end
end