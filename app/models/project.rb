class Project < ActiveRecord::Base
  attr_accessible :name

  has_many :tickets, :dependent => :delete_all

  has_many :permissions, :as => :thing

  validates :name, :presence => true, :uniqueness => true

  scope :readable_by, lambda {|user| joins(:permissions).where(:permissions =>
                                       {:action => 'view', :user_id => user.id })
  }

  def self.for(user)
    user.admin? ? Project : Project.readable_by(user)
  end
end
