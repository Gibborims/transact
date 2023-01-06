# Whitebox technical assessment Solution

## Project Setup ⚙️

To run this project successfully, there are a few setup that needs to be done.

* Install curl or use postman for running and testing the requests
* Have [postgresql](https://www.cherryservers.com/blog/how-to-install-and-setup-postgresql-server-on-ubuntu-20-04) and [rails-7](https://blog.corsego.com/install-ruby-on-rails-7-on-ubuntu) installed


## Run the project 🏃🏽

* Open the terminal
* Pull the repository
* `cd` into the project
* Run `rails s -b localhost -p 3001`. You can choose any available port in your terminal environment.
* Migrations
  * You need to run the migration for this project
  * open a new terminal, `cd` into the base project and run `bin/rake db:migrate` this runs the migration in the migrate folder.
* Tests
  * To run the specified tests in the project
  * You need to run `bundle exec rspec` this runs all the test in the spec folder.
  
## Design Considerations 🤔
* Currency types authenticity are not validated before they are saved into the database. In order to validate, this is a [link](https://gist.github.com/semmons99/852788) of the currencies that can be used for validation.

## Project Improvement Suggestions 🔧

* Caching of requests:
  * Requests cached helps improve the response time for when a resource is requested.
* Pagination:
  * Paginantion helps to  reduce the size of the json object that is sent.
* DB Indexing:
  * Indexing frequently queried columns by, on th database helps in faster queries.

## Project APIs 🔌

#### Post
Example request - `127.0.0.1:3001/api/v1/transactions`
`curl -X POST -H "Content-Type: application/json" -d '{"customer_id":1,"input_amt": 5.30, "input_currency": "EUR", "output_amt": 6.10, "output_currency": "USD"}' http://127.0.0.1:3001/api/v1/transactions`
###### Successful request - `200 Created`
```json
{
  "customer_id":1,
  "input_amt": 5.30,
  "input_currency": "EUR",
  "output_amt": 6.10,
  "output_currency": "USD"
}
```
Example response

```json
{
  "resp_code": "000",
  "resp_desc": {
    "customer_id": 1,
    "input_amt": 5.30,
    "input_currency": "EUR",
    "output_amt": 6.10,
    "output_currency": "USD",
    "status": true
  }
}
```

#### Get
Example request - `127.0.0.1:3001/api/v1/transactions`

###### Successful request
`curl http://127.0.0.1:3001/api/v1/transactions`

Example response

```json
{
  "errors":[],
  "rows":
  [
    {
      "id":"40a6b9d1-e52e-4c60-94db-4629cd13b728",
      "customer_id":1,
      "input_amt":"5.5",
      "input_currency":"EUR",
      "output_amt":"6.7",
      "output_currency":"USD",
      "status":true
    },
    {
      "id":"d2e9a294-18ba-429d-a712-8b50961f537e",
      "customer_id":1,
      "input_amt":"5.5",
      "input_currency":"EUR",
      "output_amt":"3.8",
      "output_currency":"GPD",
      "status":true
    }
  ]
}
```
