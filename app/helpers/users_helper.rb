module UsersHelper

  # Returns the Gravatar for the given user.
  def gravatar_for(user, size: 120)
#   def gravatar_for(user, options = { size: 80 })
#    size = options[:size]
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
#    gravatar_url = "https://www.gravatar.com/avatar/#{gravatar_id}"
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?d=wavatar&s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
#    debugger
  end

end
