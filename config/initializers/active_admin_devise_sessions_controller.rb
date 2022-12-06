class ActiveAdmin::Devise::SessionsController
  include ::ActiveAdmin::Devise::Controller


 def destroy 
  sign_out_and_redirect(current_admin_user)
 end

end