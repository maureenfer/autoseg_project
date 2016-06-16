class Task < ActiveRecord::Base
  belongs_to :list

  validates :name,        presence: true
  validates :description, presence: true
end
