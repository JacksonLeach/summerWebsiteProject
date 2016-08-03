class Qset < ActiveRecord::Base
	has_and_belongs_to_many :questions
	validates :name, presence: true
	has_many :set_results
	belongs_to :user
	has_and_belongs_to_many :school_classes
	
end
class MyLog
  def self.debug(message=nil)
    @my_log ||= Logger.new("#{Rails.root}/log/my.log")
    @my_log.debug(message) unless message.nil?
  end
end
