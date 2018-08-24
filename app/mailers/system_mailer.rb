class SystemMailer < ApplicationMailer
  default from: 'trung_app@example.com'
 
  def system_email
    @admin = AdminUser.first
    @revenue = Cart.active.where('DATE(created_at) = ?',Date.today)
    # @pricecart= @revenue.totalprice
    mail(to: @admin.email, subject: 'Today Revenue')
  end
end
