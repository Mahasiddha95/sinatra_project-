require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  def reset_both_tables
    seed_sql = File.read('spec/seeds/music_library.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: "music_library_test" })
    connection.exec(seed_sql)
  end
  
    before(:each) do 
      reset_both_tables
    end

  context "POST /albums" do
    it 'returns 200 OK' do
      post_response = post(
        '/albums',
        title: "Voyage",
        release_year: 2022,
        artist_id: 2
      )

      expect(post_response.status).to eq(200)

      get_response = get('/albums')

      expect(get_response.status).to eq 200
      expect(get_response.body).to include "Voyage"
    end
  end 

    context "GET /artists" do
      it 'returns 200 OK' do
        get_response = get('/artists')
        expect(get_response.status).to eq(200)
        expect(get_response.body).to include("<h1>Artists</h1>")
        expect(get_response.body).to include('<a href="/artists/1">Pixies</a>')
        expect(get_response.body).to include('<a href="/artists/2">ABBA</a>')
        expect(get_response.body).to include('<a href="/artists/3">Taylor Swift</a>')
        expect(get_response.body).to include('<a href="/artists/3">Nina Simone</a>')
      end
    end
    

      xit 'returns 404 Not Found' do
        response = get('/albums?id=276278')

        expect(response.status).to eq(404)
        expect(response.body).to eq("Sorry! We couldn't find this post.")
      end
     

    context "GET /albums" do
      it 'returns a list of albums' do
        get_response = get('/albums')
  
        expect(get_response.status).to eq(200)
        expect(get_response.body).to include("<h1>Albums</h1>")
        expect(get_response.body).to include('<a href="/albums/1">Doolittle</a>')
        expect(get_response.body).to include('<a href="/albums/2">Surfer Rosa</a>')
        expect(get_response.body).to include('<a href="/albums/3">Waterloo</a>')
      end
    end 

      context "POST /artists" do
        it 'returns 200 OK' do
          post_response = post(
            '/artists',
            name: "Wild nothing",
            genre: "Indie"
          )
          expect(post_response.status).to eq(200)
          get_response = get('/artists')
    
          expect(get_response.status).to eq 200
          expect(get_response.body).to include("Wild nothing")
        end
      end 

      context "GET /albums/:id " do 
        it 'should return info about album 1' do
          get_response = get('/albums/1')
          expect(get_response.status).to eq 200
          expect(get_response.body).to include('<h1>Doolittle</h1>')
          expect(get_response.body).to include("Release year: 1989")
          expect(get_response.body).to include("Artist: Pixies")
        end 
      end 

      context "GET /artists/:id " do 
        it 'should return info about any artist' do
          get_response = get('/artists/1')
          expect(get_response.status).to eq 200
          expect(get_response.body).to include('<h1>Pixies</h1>')
          expect(get_response.body).to include("Rock")
        end 
      end 
end
