ActiveAdmin.register Order do
  permit_params :status

  filter :status
  filter :created_at

  index do
    selectable_column
    id_column
    column :user do |order|
      order.user&.email
    end
    column :status do |order|
      status_tag order.status
    end
    column :subtotal do |order|
      number_to_currency(order.subtotal)
    end
    column :tax do |order|
      number_to_currency(order.tax)
    end
    column :total do |order|
      number_to_currency(order.total)
    end
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :user do |order|
        order.user&.email
      end
      row :status do |order|
        status_tag order.status
      end
      row :subtotal do |order|
        number_to_currency(order.subtotal)
      end
      row :tax do |order|
        number_to_currency(order.tax)
      end
      row :total do |order|
        number_to_currency(order.total)
      end
      row :created_at
    end

    panel "Order Items" do
      table_for order.order_items do
        column :product do |item|
          item.product&.name
        end
        column :quantity
        column :unit_price do |item|
          number_to_currency(item.unit_price)
        end
        column :line_total do |item|
          number_to_currency(item.line_total)
        end
      end
    end
  end

  form do |f|
    f.inputs "Update Order Status" do
      f.input :status, as: :select,
              collection: ["pending", "paid", "shipped"]
    end
    f.actions
  end
end
