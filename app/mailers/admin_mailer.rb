class AdminMailer < ApplicationMailer
  def btp_mail(btp:)
    @btp = btp
    mail(
      to: ENV['KDV_ADMIN_MAIL'],
      subject: 'Some products are running low'
    )
  end
end
