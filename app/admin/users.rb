ActiveAdmin.register User do
  permit_params :email, :street_address, :city, :postal_code, :province_id

  filter :email
  filter :created_at

  index do
    selectable_column
    id_column
    column :email
    column :street_address
    column :city
    column :province do |user|
      user.province&.name
    end
    column :postal_code
    column :orders_count do |user|
      user.orders.count
    end
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :email
      row :street_address
      row :city
      row :province do |user|
        user.province&.name
      end
      row :postal_code
      row :created_at
    end

    panel "Customer Orders" do
      table_for user.orders do
        column("Order #") { |o| link_to "##{o.id}", admin_order_path(o) }
        column :status do |o|
          status_tag o.status
        end
        column :total do |o|
          number_to_currency(o.total)
        end
        column :created_at
      end
    end
  end
end
