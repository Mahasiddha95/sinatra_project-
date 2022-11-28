require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "POST /albums" do
    it 'returns 200 OK' do
      post_response = post(
        '/albums',
        title: "Voyage",
        release_year: 2022,
        artist_id: 2
      )

      expect(post_response.status).to eq(200)

      get_response = get('/albums/13')

      expect(get_response.status).to eq 200
      expect(get_response.body).to eq "id=13,title=Voyage,release_year=2022,artist_id=2"
    end

    it 'returns 404 Not Found' do
      response = get('/albums?id=276278')

      expect(response.status).to eq(404)
      expect(response.body).to eq("Sorry! We couldn't find this post.")
    end
  end
end
