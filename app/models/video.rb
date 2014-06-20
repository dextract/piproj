class Video < Visual

  def full_name
    #"#{url} => #{description} uploaded by #{User.find(user_id).name}"
    "#{url}|#{description}"
  end

end
