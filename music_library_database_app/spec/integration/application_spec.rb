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

      get_response = get('/albums/13')

      expect(get_response.status).to eq 200
      expect(get_response.body).to eq "id=13,title=Voyage,release_year=2022,artist_id=2"
    end
  end 

    context "GET /artists" do
      it 'returns 200 OK' do
        get_response = get('/artists')
  
        expect(get_response.status).to eq(200)
        expect(get_response.body).to eq "Pixies, ABBA, Taylor Swift, Nina Simone"
      end

      it 'returns 404 Not Found' do
        response = get('/albums?id=276278')

        expect(response.status).to eq(404)
        expect(response.body).to eq("Sorry! We couldn't find this post.")
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
          expect(get_response.body).to include("nothing")
        end
      end 

      context "GET /albums/:id " do 
        xit 'should return info about album 1' do

          get_response = get('/albums_id/1')
          expect(get_response.status).to eq 200
          expect(get_response.body).to include("Doolittle")
          expect(get_response.body).to include("Release year: 1989")
          expect(get_response.body).to include("Artist: Pixies")
        

        end 
      end 
   end
