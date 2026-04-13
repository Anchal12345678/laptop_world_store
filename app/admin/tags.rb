ActiveAdmin.register Tag do
  permit_params :name

  filter :name

  index do
    selectable_column
    id_column
    column :name
    column :products_count do |tag|
      tag.products.count
    end
    actions
  end

  form do |f|
    f.inputs "Tag Details" do
      f.input :name
    end
    f.actions
  end
end
