require 'offsite_payments'
require 'offsite_payments/action_view_helper'

ActionView::Base.send(:include, OffsitePayments::ActionViewHelper)
OffsitePayments.mode = :test
Rails.configuration.offsite_payments = YAML.load_file("#{Rails.root}/config/offsite_payments.yml")[Rails.env]
