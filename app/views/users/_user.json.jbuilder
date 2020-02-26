json.extract! user, :id, :username, :password, :firstname, :middlename, :lastname, :email, :gender, :occupation, :age, :created_at, :updated_at
json.url user_url(user, format: :json)
