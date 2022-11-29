# GET /artists Route Design Recipe

_Copy this design recipe template to test-drive a Sinatra route._

## 1. Design the Route Signature

You'll need to include:
  * the HTTP method - GET
  * the path - /artists 
  * any query parameters (passed in the URL) - NONE
  * or body parameters (passed in the request body) - 
  NONE

## 2. Design the Response

The route might return different responses, depending on the result.

For example, a route for a specific blog post (by its ID) might return `200 OK` if the post exists, but `404 Not Found` if the post is not found in the database.

Your response might return plain text, JSON, or HTML code. 

_Replace the below with your own design. Think of all the different possible responses your route will return._

```
# Expected response (200 OK)
returns Pixies, ABBA, Taylor Swift, Nina Simone
```

```
# Expected response (404 Not Found)
Sorry! We couldn't find this post.
```

## 3. Write Examples

_Replace these with your own design._

```
# Request:

GET /artists


# Expected response:

Response for 200 OK

Pixies, ABBA, Taylor Swift, Nina Simone
```

```
# Request:

GET /artists?id=276278

# Expected response:

Response for 404 Not Found
```

## 4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "GET /artists" do
    it 'returns 200 OK' do
      get_response = get('/artists')

      expect(get_response.status).to eq(200)
      expect(get_response.body).to eq "Pixies, ABBA, Taylor Swift, Nina Simone"
    end

    xit 'returns 404 Not Found' do
      response = get('/albums?id=276278')

      expect(response.status).to eq(404)
      expect(response.body).to eq("Sorry! We couldn't find this post.")
    end
  end
end
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.
