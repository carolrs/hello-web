# {{ GET/POST }} Route Design Recipe

![Sequence diagram for Web](docs/sort-names-diagram.png?raw=true "Web Project sequence diagram")


## 1. Design the Route Signature
```
get '/names' do
    names = params[:names]
    return names    
  end

  post '/sort-names' do
    names = params[:names]
    return names.split(",").sort!.join(",")
  end

  
  http://localhost:9292/sort-names  --data=Joe,Alice,Zoe,Julia,Kieran
  
  http://localhost:9292/names?names=Joe,Alice,Zoe,Julia,Kieran
  ```
## 2. Design the Response

```
Response for 200 OK
#"Julia, Mary, Karim"


response for 200 OK
#"Alice,Joe,Julia,Kieran,Zoe"

```
# Request:
```
GET /names?names=Julia,Mary,Karim
curl --location --request GET 'http://localhost:9292/names?names=Julia,Mary,Karim'
```
# Expected response:

```
Response for 200 OK
#"Julia,Mary,Karim"
```
# Request:
```
POST /sort-names --data=Joe,Alice,Zoe,Julia,Kieran
curl --location --request POST 'http://localhost:9292/sort-names' \
--form 'names="Joe,Alice,Zoe,Julia,Kieran"'
```
# Expected response:
```
response for 200 OK
#"Alice,Joe,Julia,Kieran,Zoe"
```

## 4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "GET /" do
    it  it "returns 200 OK with the right content"  do
      # Assuming the post with id 1 exists.
      response = get("/names", names: "Julia, Mary, Karim")


     expect(response.status).to eq(200)
     expect(response.body).to eq("Julia, Mary, Karim")
    end

  context "POST to /sort-names" do
    it "returns 200 OK with the right content" do
      response = post("/sort-names", names: "Joe,Alice,Zoe,Julia,Kieran")

     expect(response.status).to eq(200)
    expect(response.body).to eq("Alice,Joe,Julia,Kieran,Zoe")
    end
  end
end
```


