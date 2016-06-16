class List < ActiveRecord::Base
  belongs_to :user
  has_many   :tasks, dependent: :destroy
  has_many   :favorites, dependent: :destroy
  accepts_nested_attributes_for :tasks

  validates :name, presence: true


  scope :last_updated, -> {
    order('updated_at DESC, created_at DESC').limit(1)
  }
end
