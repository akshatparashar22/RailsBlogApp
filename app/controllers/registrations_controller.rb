class RegistrationsController < Devise::RegistrationsController
    before_action :authenticate_user!

    def destroy
        # Store the user's email before deletion for sending follow-up email
        email = current_user.email
        puts email
    
        # Destroy user's associated articles and comments before deleting the user
        current_user.articles.destroy_all
        
        # Delete the user account
        if current_user.destroy
          # Trigger the Sidekiq job to send a follow-up email after the account deletion
          SendFollowUpEmailJob.set(wait: 1.minutes).perform_later(email)
        #   AccountMailer.deactivate_account(email)
    
          # Sign the user out and redirect them with a message
          respond_to do |format|
            format.html { redirect_to root_path, notice: 'Your profile has been successfully deleted.' }
          end
        else
          # Handle failure to delete account
          redirect_to edit_user_registration_path, alert: 'Failed to delete your profile. Please try again.'
        end
      end
    end