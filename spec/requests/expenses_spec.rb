require 'rails_helper'
require 'byebug'

RSpec.describe "Expenses", type: :request do
  describe "GET /expenses" do

    it 'should return OK' do 
      get '/expenses'
      payload = JSON.parse(response.body)
      expect(payload).to be_empty
      expect(response).to have_http_status(:ok)
    end

    context 'with data in the DB' do
      let!(:user) { create(:user) }
      let!(:other_user) { create(:user) }
      let!(:expenses) { create_list(:expense, 5, user_id: user.id) }
      let!(:other_user_expenses) { create_list(:expense, 5, user_id: other_user.id) }

      it 'should return all expenses in the db' do
        get "/expenses?user_id=#{user.id}"
        payload = JSON.parse(response.body)
        expect(payload).not_to be_empty
        expect(payload.size).to eq(expenses.size)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "GET /expenses/{id}" do
    let!(:expense) { create(:expense) }

    it 'should return a expense' do
      get "/expenses/#{expense.id}"
      payload = JSON.parse(response.body)
      expect(payload).not_to be_empty
      expect(payload['id']).to eq(expense.id)
      expect(payload['name']).to eq(expense.name)
      expect(payload['description']).to eq(expense.description)
      expect(payload['ammount']).to eq(expense.ammount)
      expect(payload['type']).to eq(expense.type)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /expenses" do
    let!(:user) { create(:user)}
    let!(:create_params) { {'expense' => { 'name' => 'name 1', 'description' => 'description 1', 'ammount' => 6500.00, 'type' => 'outcome', 'user_id' => user.id}} }
    before { post '/expenses', params: create_params }

    it 'should create a new expense and return it' do
      payload = JSON.parse(response.body)
      expect(payload).to include('id', 'name', 'description', 'ammount', 'type', 'user_id')
      expect(response).to have_http_status(:created)
    end
  end

  describe "PUT /expenses" do
    let!(:user) { create(:user)}
    let!(:expense) { create(:expense) }
    let!(:update_params) { {'expense' => { 'name' => 'name 2', 'description' => 'description 2', 'ammount' => 500.00, 'type' => 'income', 'user_id' => user.id}} }
    before { put "/expenses/#{expense.id}", params: update_params }

    it 'should update the provided expense and return it' do
      payload = JSON.parse(response.body)
      expect(payload).to include('id', 'name', 'description', 'ammount', 'type', 'user_id')
      expect(payload['name']).to eq(update_params['expense']['name'])
      expect(payload['id']).to eq(expense.id)
      expect(response).to have_http_status(:ok)
    end
  end
end