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


## Founders:
- `Hanting Ge`: hantingge@brandeis.edu
- `Daihao Xue`: daihaoxue@brandeis.edu
- `Shuo Shi`: sshi@brandeis.edu
- `Chongming Wang`: chongmingw@brandeis.edu


## Core Functionalities
- 1. Roommate Matching (Lessee to Lessee)
- 2. Property Matching (Lessee to Lessor)


## Rommate Matching Principles
- 1. Location: (...). 
- 2. Time Delta: (...)
- 3. Rent Expectation: (formula...)
- 4. Smoking
- 5. 



## Property Matching Principles
- 1. Location
- 2. Time
- 3. Rent
- 4. Smoke

....


