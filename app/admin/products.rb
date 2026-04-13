ActiveAdmin.register Product do
  permit_params :name, :description, :current_price, :sale_price,
              :on_sale, :stock_quantity, :category_id, :image,
              tag_ids: []

  filter :name
  filter :category
  filter :on_sale
  filter :stock_quantity

  index do
    selectable_column
    id_column
    column :name
    column :category
    column :current_price
    column :sale_price
    column :on_sale
    column :stock_quantity
    column :image do |product|
      if product.image.attached?
        image_tag product.image, height: 50
      else
        "No Image"
      end
    end
    actions
  end

  form do |f|
  f.inputs "Product Details" do
    f.input :name
    f.input :description
    f.input :category
    f.input :current_price, min: 0.01
    f.input :sale_price, min: 0.01, required: false
    f.input :on_sale
    f.input :stock_quantity, min: 0
    f.input :tags, as: :check_boxes,
            collection: Tag.all
    f.input :image, as: :file
  end
  f.actions
end

  show do
    attributes_table do
      row :name
      row :category
      row :description
      row :current_price
      row :sale_price
      row :on_sale
      row :stock_quantity
      row :image do |product|
        if product.image.attached?
          image_tag product.image, height: 200
        else
          "No Image"
        end
      end
    end
  end
end
