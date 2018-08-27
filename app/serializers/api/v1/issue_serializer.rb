module Api::V1
  class IssueSerializer < ActiveModel::Serializer
    attributes :title, :body, :user_id
  end
end
