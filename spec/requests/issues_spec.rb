require 'rails_helper'

RSpec.describe 'Issue API', type: :request do
  let!(:user) { create(:user) }
  let!(:issues) { create_list(:issue, 5, user: user) }
  let(:issue_id) { issues.first.id }

  describe 'GET /issues' do
    before { get '/api/v1/issues' }

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
   before { get "/api/v1/issues/#{issue_id}" }

   context 'when the record exists' do
     it 'returns the issue' do
       expect(json).not_to be_empty
       expect(json['id']).to eq(issue_id)
     end

     it 'returns status code 200' do
       expect(response).to have_http_status(200)
     end
   end

   context 'when the record does not exist' do
     let(:issue_id) { 100 }

     it 'returns status code 404' do
       expect(response).to have_http_status(404)
     end

     it 'returns a not found message' do
       expect(json["error_message"]).to match(/Not found/)
     end
   end
  end

  describe 'POST /issues' do
    let(:valid_params) {{ title: 'First issue', user_id: user.id }}
    let(:valid_headers) {{ "Authorization" => "Basic YWRtaW46cGFzc3dvcmQ=", "Content-Type" => "application/json"}}
	  context 'when the request is valid' do
		  before{ post '/api/v1/issues', params: valid_params, header: valid_headers }

       it 'creates a issue' do
         expect(json['title']).to eq('First issue')
       end

       it 'returns status code 201' do
         expect(response).to have_http_status(201)
       end
     end

     context 'when the request is invalid' do
       before { post '/api/v1/issues', params: { title: 'Wrong issue' } }

       it 'returns status code 422' do
         expect(response).to have_http_status(422)
       end

       it 'returns a validation failure message' do
         expect(json['error_message']).to match(/Something wrong/)
       end
     end
  end

  describe 'PUT /issues/:id' do
    let(:valid_params) { { title: 'Shopping' } }

    context 'when the record exists' do
      before { put "/api/v1/issues/#{issue_id}", params: valid_params }

      it 'updates the record' do
        expect(json).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /issues/:id' do
    before { delete "/api/v1/issues/#{issue_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
