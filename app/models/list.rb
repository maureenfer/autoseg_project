class List < ActiveRecord::Base
  belongs_to :user
  has_many   :tasks, dependent: :destroy
  has_many   :favorites, dependent: :destroy

  validates :name, presence: true
end
