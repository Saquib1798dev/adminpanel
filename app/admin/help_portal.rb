ActiveAdmin.register HelpPortal do
  permit_params :description, :title, :help_type
  #actions :show, :create, :edit, :update
  actions :all, :except => [:destroy]


  index do
    selectable_column
    column :id
    column :title
    column :description
    column :help_type
    actions
  end

  filter :type

  form do |f|
    f.inputs do
      f.input :help_type , :as => :select, collection: (['Privacy Policy', 'Term And Condition'])
      f.input :title
      f.input :description, as: :quill_editor, class: "description-help"
    end
    f.actions
  end

  show do
    attributes_table do
      row :help_type
      row :id
      row :description
    end
  end

end
