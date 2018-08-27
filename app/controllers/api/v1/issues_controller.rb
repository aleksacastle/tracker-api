module Api::V1
  class IssuesController < Api::BaseController
    include ActionController::Serialization
    before_action :set_issue, only: %w(show update destroy)

    def index
      @issues = Issue.paginate(page: params[:page], per_page: 25)
      json_response(@issues)
    end

    def create
      @issue = Issue.create!(issue_params)
      json_response(@issue, :created)
    end

    def show
      json_response(@issue)
    end

    def update
      @issue.update(issue_params)
      head :no_content
    end

    def destroy
      @issue.destroy
      head :no_content
    end

    private

    def issue_params
      params.require(:issue).permit(:title, :body, :status, :user_id)
    end

    def set_issue
      @issue = Issue.find(params[:id])
    end
  end
end
