class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: :classifications).where(classifications: {:name => 'Catamaran'}).uniq
  end

  def self.sailors
    joins(boats: :classifications).where(classifications: {:name => 'Sailboat'}).uniq
  end

  def self.talented_seamen
    # binding.pry
    # talents = (moto & sailors).uniq
    where("id IN (?)", self.sailors.map(&:id) & self.moto.map(&:id))
  end

  def self.moto
    moto =joins(boats: :classifications).where(classifications: {:name => 'Motorboat'}).uniq
  end

  def self.non_sailors
    # all - self.sailors
    where.not("id IN (?)", self.sailors.map(&:id))
  end

end
