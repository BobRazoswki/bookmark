require 'rest-client'

 def send_notification(email, subject, message)
      RestClient.post "https://api:key-1233ceff8ae2c3122bbe2142ea629427"\
      "@api.mailgun.net/v2/sandbox27040c50b6e045f7a7ac475b51b9ac43.mailgun.org/messages",
      :from => "Mailgun Sandbox <postmaster@sandbox27040c50b6e045f7a7ac475b51b9ac43.mailgun.org>",
      :to => email,
      :subject => subject,
      :html => message
    end
send_notification("news@sweetbid.fr","ubject", "message")