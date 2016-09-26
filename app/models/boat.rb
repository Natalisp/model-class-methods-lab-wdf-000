class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    all.order("id asc").limit(5)
  end

  def self.dinghy    
    where(arel_table[:length].lt(20))
  end

  def self.ship
     where(arel_table[:length].gteq(20))
  end

  def self.last_three_alphabetically
    limit(3).order('name desc')
  end

  def self.without_a_captain
    where(arel_table[:captain_id].eq(nil))
  end

  def self.sailboats
    joins(:classifications).where(:classifications => { :name => 'Sailboat' })
  end

  def self.with_three_classifications
    joins(:classifications).group("boats.id").having("count(*) = 3")
  end

end
