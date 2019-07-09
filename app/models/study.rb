class Study < ApplicationRecord

  def self.monthSessions
    Study.where("created_at >=  ? and created_at <= ?", 
                                 DateTime.now.beginning_of_month, 
                                 DateTime.now.end_of_month).reverse
  end
end
