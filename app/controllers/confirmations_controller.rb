class ConfirmationsController < Devise::ConfirmationsController
    skip_before_action :authenticate!
    def show
        self.resource = resource_class.confirm_by_token(params[:confirmation_token])
        # sign_in(resource)
        render json: {status: "The emailid is being confirmed. You can login now!!"}
        
    end
    def send_reconfirmation_instructions
        binding.pry
        @reconfirmation_required = false

        unless @skip_confirmation_notification
          send_confirmation_instructions
        end
    end
    # private
    # def after_confirmation_path_for(resource_name,resource)
    #     sign_in(resource)
    #     # render json: {status: "Done"}
    # end
end