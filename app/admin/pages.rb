ActiveAdmin.register Page do
  permit_params :title, :content, :page_type

  filter :page_type
  filter :title

  index do
    selectable_column
    id_column
    column :title
    column :page_type
    column :updated_at
    actions
  end

  form do |f|
    f.inputs "Page Details" do
      f.input :title
      f.input :page_type, as: :select,
              collection: [["Contact Page", "contact"], ["About Page", "about"]]
      f.input :content, as: :text, input_html: { rows: 10 }
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :page_type
      row :content
      row :updated_at
    end
  end
end
