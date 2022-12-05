class SocialMediaUser < User
  def self.create_user_for_google(data, name)
    email = data["email"]
    user = User.find_by_email(email)
    if user.nil?
      user =  SocialMediaUser.create!(email: email, password: 12345678, full_name: name)
    end
    return {check: true, data: user} 
  end 
end
