# the movies db
class Movie < ActiveRecord::Base

  @@grandfathered_date = Time.zone.parse('1 November 1968')

  # scope :all_ratings, -> { distinct(:rating).pluck(:rating) }
  def self.all_ratings
    %w[G PG PG-13 R NC-17]
  end

  validates :title, presence: true
  validates :release_date, presence: true
  validate :released_1895_or_later
  validates :rating,
            inclusion: { in: Movie.all_ratings },
            unless: :grandfathered?

  def released_1895_or_later
    errors.add(:release_date, 'must be March 19, 1895 or later') if
      release_date && release_date < Time.zone.parse('19 March 1895')
  end

  def grandfathered?
    release_date && release_date < @@grandfathered_date
  end

  def self.ordered_ratings(ratings, order_by = nil)
    where(rating: ratings).order(order_by)
  end
end
