ActiveAdmin.register User do
  permit_params :email, :password, :full_phone_number, :full_name

  index do
    selectable_column
    id_column
    column :email
    column :full_phone_number
    column :full_name
    column :type
    actions
  end

  filter :email
  filter :full_phone_number
  

  form do |f|
    f.inputs do
      f.input :email
      f.input :full_phone_number
      f.input :full_name
      f.input :password
      f.input :type , :as => :select, collection: (['EmailSmsUser', 'SocialMediaUser'])
    end
    f.actions
  end

end
