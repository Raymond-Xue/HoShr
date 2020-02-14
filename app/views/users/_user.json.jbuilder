json.extract! user, :id, :username, :password, :email, :firstname, :middlename, :lastname, :created_at, :updated_at
json.url user_url(user, format: :json)
