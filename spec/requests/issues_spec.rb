require 'rails_helper'

RSpec.describe 'Issue API', type: :request do
  let!(:user) { create(:user) }
  let!(:issues) { create_list(:issue, 5, user: user) }
  let(:valid_params) { { title: 'First issue', user_id: user.id.to_s }.to_json}
  let(:issue_id) { issues.first.id }
  let(:title) { issues.first.title }
  let(:headers) { valid_headers }

  describe 'GET /issues' do
    before { get '/api/v1/issues', params: {}, headers: headers }

    it 'returns issues' do
      # json is custom helper
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /issues/:id' do
   before { get "/api/v1/issues/#{issue_id}", params: { id: issue_id, user_id: user.id }, headers: headers }
   context 'when the record exists' do
     it 'returns the issue' do
       expect(json).not_to be_empty
       expect(json['title']).to eq(title)
     end

     it 'returns status code 200' do
       expect(response).to have_http_status(200)
     end
   end

   context 'when the record does not exist' do
     it 'returns status code 404' do
       issue_id = 100
       expect { get "/api/v1/issues/#{issue_id}", params: {}, headers: headers }.
		       to raise_error(ActiveRecord::RecordNotFound)
     end
   end
  end

  describe 'POST /issues' do
	  context 'when the request is valid' do
		  before{ post '/api/v1/issues', params: valid_params, headers: headers }

       it 'creates a issue' do
         expect(json['title']).to eq('First issue')
       end

       it 'returns status code 201' do
         expect(response).to have_http_status(201)
       end
     end

     context 'when the request is invalid' do
       let(:invalid_params) { { title: nil }.to_json }
       before { post '/api/v1/issues', params: invalid_params, headers: headers }

       it 'returns status code 422' do
         expect(response).to have_http_status(422)
       end

       it 'returns a validation failure message' do
         expect(json['error_message']).to match(/Something wrong/)
       end
     end
  end

  describe 'PUT /issues/:id' do
    let(:valid_params) { { title: 'Refactor' }.to_json }

    context 'when the record exists' do
      before { put "/api/v1/issues/#{issue_id}", params: valid_params, headers: headers }

      it 'updates the record' do
        expect(json).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /issues/:id' do
    before { delete "/api/v1/issues/#{issue_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
