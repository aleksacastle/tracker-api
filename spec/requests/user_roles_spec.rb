require 'rails_helper'

RSpec.describe 'User Roles', type: :request do
	let(:manager) { create(:user, manager: true) }
	let(:owner) { create(:user) }
	let(:user) { create(:user) }
	let(:issues) { create_list(:issue, 10, user_id: user.id) }

	describe 'manager can' do
		before do
			@auth_token = signin(manager)
			# custom helper
			valid_headers
			@issues = issues
		end

		it 'see all issues' do
			get '/api/v1/issues', params: {}, headers: valid_headers
			expect(json.size).to eq(10)
		end

		it 'update any issue' do
			issue_id = @issues.first.id

			put "/api/v1/issues/#{issue_id}", params: { title: "Manager title" }.to_json, headers: valid_headers
			get "/api/v1/issues/#{issue_id}", params: {}, headers: valid_headers

			expect(json['title']).to eq('Manager title')
		end

		it 'delete any issue' do
			issue_id = @issues.last.id

			delete "/api/v1/issues/#{issue_id}", params: {}, headers: valid_headers
			get "/api/v1/issues/#{issue_id}", params: {}, headers: valid_headers

			expect(json['message']).to match(/Couldn't find Issue with 'id'=#{issue_id}/)
		end
	end

	describe 'owner can' do
		before do
			@issues = issues
			@issues[0...5].each do |issue|
				issue.user_id = owner.id
				issue.save!
			end
			@auth_token = signin(owner)
			@issue_id = @issues.last.id
			# custom helper
			valid_headers
		end

		it 'see only owned issues' do
			get '/api/v1/issues', params: {}, headers: valid_headers
			expect(json.size).to eq(5)
		end

		it 'see only owned issue' do

			get "/api/v1/issues/#{@issue_id}", params: {}, headers: valid_headers
			expect(json['message']).to match(/ExceptionHandler::AuthenticationError/)
		end

		it 'update only owned issue' do

			put "/api/v1/issues/#{@issue_id}", params: { title: "Manager title" }.to_json, headers: valid_headers

			expect(json['message']).to match(/ExceptionHandler::AuthenticationError/)
		end

		it 'delete only owned issue' do

			delete "/api/v1/issues/#{@issue_id}", params: {}, headers: valid_headers

			expect(json['message']).to match(/ExceptionHandler::AuthenticationError/)
		end
	end
end