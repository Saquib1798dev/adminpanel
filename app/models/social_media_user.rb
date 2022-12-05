class SocialMediaUser < User
  def self.create_user_for_google(data)
    email = data["email"]
    if User.find_by_email(email).nil?
      
      User.create!(email: email, password: )
    else
      return true
    end
  end 
end