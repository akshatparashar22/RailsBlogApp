class AccountMailer < ApplicationMailer
    def deactivate_account(email)
        @title = "We're Sorry to See You Go! Join Us Again?"
        @change = "Deactivated"
        mail(
          to: email,
          from: 'email for sender',
          subject: "We're Sorry to See You Go! Join Us Again?"
        ) do |format|
          format.html { render 'deactivate_account_mailer' }
        end
  
        # Schedule follow-up email 5 minutes later
        SendFollowUpEmailJob.set(wait: 1.minutes).perform_later(email)
      end

      # def activation_mail(email)
      #   mail(to: email)
      #   subject: "Welcome to my prestigious Rails-learning-project"
      # end
  
      def follow_up_email(email)
        mail(
          to: email,
          from: 'akshatparashar2001@gmail.com',
          subject: "We Miss You at Rails-Blog-App"
        ) do |format|
          format.html { render 'follow_up_email' }
        end
      end
end
