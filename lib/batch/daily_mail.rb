class Batch::DailyMail
  def self.send_dailymail
    DailyMailer.daily_mail_to_all.deliver_now
    p "デイリーメールを送信しました。"
  end
end