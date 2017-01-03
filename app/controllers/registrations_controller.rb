class RegistrationsController < Devise::RegistrationsController
    
    protected
    
    def after_update_path_for(resource)
      request.referrer
    end
    
    def update_resource(resource, params)
        if params[:password].blank? && params[:password_confirmation].blank?
            resource.update_without_password(params)
        else
            super
        end
    end
    
end