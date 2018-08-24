require 'rails_helper'

RSpec.describe Issue, type: :model do
  VALID_STATUS = %w(pending progress resolved).freeze

  context 'belongs to user' do
    it { should belong_to(:user) }
  end

  context 'validates presense of title' do
    it { should validate_presence_of(:title) }
  end

  context 'define enum for status and validates value' do
    it { should define_enum_for(:status).with(VALID_STATUS) }
  end

  it 'has default status pending' do
    issue = Issue.new
    expect(issue.status).to eq(VALID_STATUS[0])
  end
end
