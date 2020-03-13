# Hoshr Development Readme

## Database initialization
* As we directly modify "schema.rb" file, "rails:reset" commend will not be suitable because it will run migration to build schema instead of using "schema.rb".
* The rule of thumb is to run the commends below whenever you want to rebuild database.
```
# shell
rails db:drop
rails db:create
rails db:schema:load
```