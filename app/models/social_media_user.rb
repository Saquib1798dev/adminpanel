class SocialMediaUser < User
  def self.create_user_for_google(data)
    email = data["email"]
    user = User.find_by_email(email)
    if user.nil?
      user =  SocialMediaUser.create!(email: email, password: 12345678)
    end
    return {check: true, data: user} 
  end 
end