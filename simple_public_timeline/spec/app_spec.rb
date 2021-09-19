require_relative '../app.rb'

describe 'Twitter Public Timeline App' do

    include Rack::Test::Methods

        def app
                TwitterPublicTimelineApp.new
        end

        it "Renders server side Twitter Public Timeline HTML View with 20 most recent Tweets" do
            get '/'
            response_body = last_response.body

            expect(last_response.status).to be(200)
            expect(response_body).to include('<h2>Recent Public Tweets</h2>')
            expect(response_body).to include('<h3>What everyone on Twitter is talking about</h3>')
            # Check whether twitter tweets table contains 20 table rows each containing a single tweet's data
            expect(response_body).to include('<tr>').exactly(20).times
        end

        it "Returns 20 most recent Tweets in response JSON format" do
            get '/tweets'
           expect(last_response.status).to be(200)
           expect(JSON.parse(last_response.body)['tweets'].length).to be (20)
        end

        # it "Returns user specified number of most recent Tweets in response JSON format" do
        #     num_tweets = rand(10)
        #     get "/tweets?num_tweets=#{num_tweets}"
        #    expect(last_response.status).to be(200)
        #    expect(JSON.parse(last_response.body)['tweets'].length).to be (num_tweets)
        # end

        it "Renders client side async JS Twitter Public Timeline HTML View with 20 most recent Tweets" do
            get '/via_js'
           expect(last_response.status).to be(200)
           expect(last_response.body).to include(<<-EXPECTED
<h2>Recent Public Tweets</h2>
<h3>What everyone on Twitter is talking about</h3>
<table>
EXPECTED
)
        end
end