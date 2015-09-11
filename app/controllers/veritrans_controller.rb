class VeritransController < ApplicationController
  # Robokassa call this action after transaction
  def paid
    create_notification

    if @notification.acknowledge # check if it’s genuine Robokassa request

      # @order.approve! # project-specific code
      render text: @notification.success_response
    else
      head :bad_request
    end
  end


  def success
    create_notification

    if @notification.acknowledge
      @order.approve!
      redirect_to user_home_path, notice: 'Successful payment'
    else
      render text: 'fraud'
    end
  end

  def fail
    redirect_to user_home_path, notice: 'Payment failed.'
  end

private

  def create_notification
    @notification = OffsitePayments.integration(:robokassa).notification(request.raw_post, secret: Rails.configuration.offsite_payments['robokasa']['password1'])
  end
end
