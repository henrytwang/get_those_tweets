class Tweet < ActiveRecord::Base
  validate :text, :uniqueness => true
  belongs_to :user
end
