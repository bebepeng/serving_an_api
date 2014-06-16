require 'rails_helper'

describe "Cars API" do

  describe 'GET /cars' do
    it 'returns a list of cars' do
      ford = create_make(name: "Ford")
      chevy = create_make(name: "Chevy")
      red_ford = create_car(color: "red", doors: 4, purchased_on: "1973-10-04", make_id: ford.id)
      blue_chevy = create_car(color: "blue", doors: 2, purchased_on: "2012-01-24", make_id: chevy.id)

      get '/cars', {}, {'Accept' => 'application/json'}

      expected_response = {
        "_links" => {
          "self" => {
            "href" => "/cars"
          }
        },
        "_embedded" => {
          "cars" => [
            {
              "_links" => {
                "self" => {
                  "href" => "/cars/#{red_ford.id}"
                },
                "make" => {
                  "href" => "/makes/#{ford.id}"
                }
              },
              "id" => red_ford.id,
              "color" => "red",
              "doors" => 4,
              "purchased_on" => "1973-10-04"
            },
            {
              "_links" => {
                "self" => {
                  "href" => "/cars/#{blue_chevy.id}"
                },
                "make" => {
                  "href" => "/makes/#{chevy.id}"
                }
              },
              "id" => blue_chevy.id,
              "color" => "blue",
              "doors" => 2,
              "purchased_on" => "2012-01-24"
            }
          ]
        }
      }

      expect(response.code.to_i).to eq 200
      expect(JSON.parse(response.body)).to eq(expected_response)
    end

    it 'returns a 200 for empty cars' do
      get '/cars', {}, {'Accept' => 'application/json'}

      expected_response = {
        "_links" => {
          "self" => {
            "href" => "/cars"
          }
        },
        "_embedded" => {
          "cars" => []
        }
      }

      expect(response.code.to_i).to eq 200
      expect(JSON.parse(response.body)).to eq(expected_response)
    end
  end

  describe 'GET /cars/:id' do
    it 'returns one car' do
      ford = create_make(name: "Ford")
      red_ford = create_car(color: "red", doors: 4, purchased_on: "1973-10-04", make_id: ford.id)


      get "/cars/#{red_ford.id}", {}, {'Accept' => 'application/json'}

      expected_response = {
        "_links" => {
          "self" => {
            "href" => "/cars/#{red_ford.id}"
          },
          "make" => {
            "href" => "/makes/#{ford.id}"
          }
        },
        "id" => red_ford.id,
        "color" => "red",
        "doors" => 4,
        "purchased_on" => "1973-10-04"
      }

      expect(response.code.to_i).to eq 200
      expect(JSON.parse(response.body)).to eq(expected_response)
    end

    it 'returns one car' do
      ford = create_make(name: "Ford")
      red_ford = create_car(color: "red", doors: 4, purchased_on: "1973-10-04", make_id: ford.id)


      get "/cars/#{red_ford.id + 1}", {}, {'Accept' => 'application/json'}

      expect(response.code.to_i).to eq 404
      expect(JSON.parse(response.body)).to eq({})

    end
  end
end


