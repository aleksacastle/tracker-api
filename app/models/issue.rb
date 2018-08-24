class Issue < ApplicationRecord
  VALID_STATUS = %w(pending progress resolved).freeze
  enum status: VALID_STATUS
  
  belongs_to :user

  validates_presence_of :title

  validates_inclusion_of :status, :in => VALID_STATUS
end
