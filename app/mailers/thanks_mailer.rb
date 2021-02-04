class ThanksMailer < ApplicationMailer
  default from: 'no-reply@gmail.com'
  # Gmailの場合、送信元の変更は別途設定必要(https://teratail.com/questions/89189)
  
  def complete_mail(user)
    @user = user
    @url = "https://a52993da6f064799b8538264d0322dfb.vfs.cloud9.ap-northeast-1.amazonaws.com/users/#{@user.id}"
    mail(subject: "会員登録が完了しました。", 
              to: @user.email)
  end
end
