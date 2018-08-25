module Api::V1
  class IssuesController < Api::BaseController
    include ActionController::Serialization
    before_action :set_issue, only: %w(show update destroy)

    def index
      render json: issues
    end

    def show
      render json: issue
    end

    def create
      new_issue = Issue.new(issue_params)

      if new_issue.save
        render json: issue, status: :created
      else
        render json: issue.errors, status: :unprocessable_entity
      end
    end

    def update
      if issue.update(issue_params)
        render json: issue
      else
        render json: issue.errors, status: :unprocessable_entity
      end
    end

    def destroy
      issue.destroy
    end

    private

    def issues
      @issues ||= Issue.all
    end

    def issue
      @issue ||= set_issue
    end

    def issue_params
      params.permit(:title, :body, :status)
    end

    def set_issue
      Issue.find(params[:id])
    end
  end
end
