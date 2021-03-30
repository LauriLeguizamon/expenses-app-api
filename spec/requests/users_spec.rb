require 'rails_helper'
require 'byebug'

RSpec.describe "Users", type: :request do
  describe "GET /users" do

    it 'should return OK' do 
      get '/users'
      payload = JSON.parse(response.body)
      expect(payload).to be_empty
      expect(response).to have_http_status(:ok)
    end

    context 'with data in the DB' do
      let!(:users) { create_list(:user, 10) }

      it 'should return all users in the db' do
        get '/users'
        payload = JSON.parse(response.body)
        expect(payload).not_to be_empty
        expect(payload.size).to eq(users.size)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "GET /users/{id}" do
    let!(:user) { create(:user) }

    it 'should return a user' do
      get "/users/#{user.id}"
      payload = JSON.parse(response.body)
      expect(payload).not_to be_empty
      expect(payload['id']).to eq(user.id)
      expect(payload['email']).to eq(user.email)
      expect(payload['password']).to eq(user.password)
      expect(payload['total_budget']).to eq(user.total_budget)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /users" do
    let!(:create_params) { {'user' => { 'email' => 'email@test.com', 'password' => 'password'}} }
    before { post '/users', params: create_params }

    it 'should create a new user and return it' do
      payload = JSON.parse(response.body)
      expect(payload).to include('id', 'email', 'password')
      expect(response).to have_http_status(:created)
    end
  end

  describe "PUT /users" do
    let!(:user) { create(:user) }
    let!(:update_params) { {'user' => { 'password' => 'password2'}} }
    before { put "/users/#{user.id}", params: update_params }

    it 'should update the provided user and return it' do
      payload = JSON.parse(response.body)
      expect(payload).to include('id', 'email', 'password')
      expect(payload['password']).to eq(update_params['user']['password'])
      expect(response).to have_http_status(:ok)
    end
  end
end