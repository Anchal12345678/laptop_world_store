ActiveAdmin.register Province do
  permit_params :name, :gst, :pst, :hst

  filter :name

  index do
    selectable_column
    id_column
    column :name
    column :gst
    column :pst
    column :hst
    actions
  end

  form do |f|
    f.inputs "Province Details" do
      f.input :name
      f.input :gst, label: "GST %", min: 0
      f.input :pst, label: "PST %", min: 0
      f.input :hst, label: "HST %", min: 0
    end
    f.actions
  end
end
