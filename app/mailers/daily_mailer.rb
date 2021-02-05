class DailyMailer < ApplicationMailer
  default from: 'no-reply@gmail.com'
  # Gmailの場合、送信元の変更は別途設定必要(https://teratail.com/questions/89189)
  
  def daily_mail_to_all
    @users = User.all
    @users.each do |user|
      @user = user
      mail(subject: "デイリー確認メール", 
              to: user.email)
    end
  end
end
