module UsersHelper


  def leave_group
    # Todo User placeholder
    user = User.find(1)
    if user.group_id == user.origin_group_id
      raise "Invalid request"
    end
    user.group_id != user.origin_group_id
    user.group_id = user.origin_group_id
    user.save

	# Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 80 })
    size         = options[:size]
    gravatar_id  = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: "gravatar")

  end
end

