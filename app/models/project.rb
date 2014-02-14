class Project < ActiveRecord::Base
  
  has_many :user_position_in_projects, dependent: :destroy
  has_many :users, through: :user_position_in_projects
  
  accepts_nested_attributes_for :user_position_in_projects,
            reject_if: ->attrs { attrs["member"] == '0'}, 
            allow_destroy: true
  
  validates :name, presence: true
  validates :abbreviation, presence: true
  validates :startdate, presence: true
  validates :enddate, presence: true
  
end
