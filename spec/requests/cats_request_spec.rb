require 'rails_helper'

RSpec.describe "Cats", type: :request do 
    # Endpoint Testing
    describe "GET /index" do
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

    describe "PATCH /update" do
        it "updates a cat" do
            cat_params = {
                cat: {
                    name: 'Shadow',
                    age: 4,
                    enjoys: 'Sleeping and cuddling.'
                }
            }
            post '/cats', params: cat_params
            cat = Cat.first
            updated_cat_params = {
                cat: {
                    name: 'Shadow',
                    age: 20,
                    enjoys: 'Sleeping and cuddling.'
                }
            }
            patch "/cats/#{cat.id}", params: updated_cat_params
            cat = Cat.first
            expect(response).to have_http_status(200)
            expect(cat.age).to eq 20
        end
    end

    describe "DELETE /destroy" do
        it "destroys a cat" do
            cat_params = {
                cat: {
                    name: 'Shadow',
                    age: 4,
                    enjoys: 'Sleeping and cuddling.'
                }
            }

            post '/cats', params: cat_params
            cat = Cat.first
            delete "/cats/#{cat.id}"
            cat = Cat.first
            expect(cat).to eq nil
        end

    end
    
    # Response status testing for create
    it "doesn't create a cat without a name and returns 422" do
        cat_params = {
            cat: {
                age: 2,
                enjoys: 'walks in the park'
            }
        }
        post '/cats', params: cat_params
        expect(response.status).to eq 422
        json = JSON.parse(response.body)
        expect(json['name']).to include "can't be blank"
    end

    it "doesn't create a cat without an age and returns 422" do
        cat_params = {
            cat: {
                name: "Nala",
                enjoys: 'walks in the park'
            }
        }
        post '/cats', params: cat_params
        expect(response.status).to eq 422
        json = JSON.parse(response.body)
        expect(json['age']).to include "can't be blank"
    end

    it "doesn't create a cat without an enjoys and returns 422" do
        cat_params = {
            cat: {
                name: "Nala",
                age: 2
            }
        }
        post '/cats', params: cat_params
        expect(response.status).to eq 422
        json = JSON.parse(response.body)
        # where json = {"enjoys"=>["can't be blank", "is too short (minimum is 10 characters)"]}
        expect(json['enjoys']).to include "can't be blank"
    end

    it "doesn't create a cat when enjoys is less than 10 characters and returns 422" do
        cat_params = {
            cat: {
                name: "Nala",
                age: 2,
                enjoys: "eats"
            }
        }
        post '/cats', params: cat_params
        expect(response.status).to eq 422
        json = JSON.parse(response.body)
        expect(json['enjoys']).to include "is too short (minimum is 10 characters)"
    end

    # Response status testing for update
    it "doesn't update a cat without a name and returns 422" do
        cat_params = {
            cat: {
                name: 'Shadow',
                age: 4,
                enjoys: 'Sleeping and cuddling.'
            }
        }
        post '/cats', params: cat_params
        cat = Cat.first    
        updated_cat_params = {
            cat: {
                name: '',
                age: 20,
                enjoys: 'Sleeping and cuddling.'
            }
        }
        patch "/cats/#{cat.id}", params: updated_cat_params
        cat = Cat.first      
        expect(response.status).to eq 422
        json = JSON.parse(response.body)
        expect(json['name']).to include "can't be blank"
    end

    it "doesn't update a cat without an age and returns 422" do
        cat_params = {
            cat: {
                name: 'Shadow',
                age: 4,
                enjoys: 'Sleeping and cuddling.'
            }
        }
        post '/cats', params: cat_params
        cat = Cat.first    
        updated_cat_params = {
            cat: {
                name: 'Oreo',
                age: '',
                enjoys: 'Sleeping and cuddling.'
            }
        }
        patch "/cats/#{cat.id}", params: updated_cat_params
        cat = Cat.first  
        expect(response.status).to eq 422
        json = JSON.parse(response.body)
        expect(json['age']).to include "can't be blank"
    end

    it "doesn't update a cat without an enjoys and returns 422" do
        cat_params = {
            cat: {
                name: 'Shadow',
                age: 4,
                enjoys: 'Sleeping and cuddling.'
            }
        }
        post '/cats', params: cat_params
        cat = Cat.first    
        updated_cat_params = {
            cat: {
                name: 'Shadow',
                age: 10,
                enjoys: ''
            }
        }
        patch "/cats/#{cat.id}", params: updated_cat_params
        cat = Cat.first  
        expect(response.status).to eq 422
        json = JSON.parse(response.body)
        expect(json['enjoys']).to include "can't be blank"
    end

    it "doesn't update a cat when enjoys is less than 10 characters and returns 422" do
        cat_params = {
            cat: {
                name: 'Shadow',
                age: 4,
                enjoys: 'Sleeping and cuddling.'
            }
        }
        post '/cats', params: cat_params
        cat = Cat.first    
        updated_cat_params = {
            cat: {
                name: 'Shadow',
                age: 4,
                enjoys: 'eating'
            }
        }
        patch "/cats/#{cat.id}", params: updated_cat_params
        cat = Cat.first
        expect(response.status).to eq 422
        json = JSON.parse(response.body)
        expect(json['enjoys']).to include "is too short (minimum is 10 characters)"
    end


end