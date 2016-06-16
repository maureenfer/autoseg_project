class Task < ActiveRecord::Base
  belongs_to :list

  validates :name,        presence: true
  validates :description, presence: true

  def self.types
    %w(Subtask)
  end
end
