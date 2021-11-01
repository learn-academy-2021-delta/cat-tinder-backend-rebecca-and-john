require 'rails_helper'

RSpec.describe "Cats", type: :request do 
    describe "Get /index" do
        it "gets a list of cats" do
            Cat.create name: 'Mittens', age: 5, enjoys: 'sunshine and warm spots'
        
            # Make a request
            get '/cats'

            cat = JSON.parse(response.body)
            expect(response).to have_http_status(200)
            expect(cat.length).to eq 1
        end
    end

    describe "POST /create" do
        it "creates a cat" do
            cat_params = {
                cat: {
                    name: 'Shadow',
                    age: 4,
                    enjoys: 'Sleeping and cuddling.'
                }
            }

            post '/cats', params: cat_params
            expect(response).to have_http_status(200)
            cat = Cat.first
            expect(cat.name).to eq 'Shadow'
        end
    end

end