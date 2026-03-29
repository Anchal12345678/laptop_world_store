ActiveAdmin.register Category do
  permit_params :name, :description

  filter :name

  index do
    selectable_column
    id_column
    column :name
    column :description
    column "Products" do |c|
      c.products.count
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
    end
    f.actions
  end
end
