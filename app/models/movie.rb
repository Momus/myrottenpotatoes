# the movies db
class Movie < ActiveRecord::Base
  has_many :reviews
  has_many :moviegoers, through: :reviews

  @@grandfathered_date = Time.zone.parse('1 November 1968')

  validates :title, presence: true
  validates :release_date, presence: true
  validate :released_1895_or_later
  validates :rating,
            # using Movie.all_ratings makes an intersting bug in at
            # least the develomplent envorinment:
            # https://stackoverflow.com/questions/17561697/argumenterror-a-copy-of-applicationcontroller-has-been-removed-from-the-module#23008837
            inclusion: { in: %w[G PG PG-13 R NC-17] }, # ::Movie.all_ratings },
            unless: :grandfathered?

  scope :with_good_reviews, lambda { |threshold|
    Movie.joins(:reviews).group(:movie_id)
         .having(['AVG(reviews.potatoes > ?', threshold.to_i])
  }
  scope :for_kids, lambda {
    Movie.where('rating in (?)', %w[G PG PG-13])
  }

  # scope :all_ratings, -> { distinct(:rating).pluck(:rating) }
  def self.all_ratings
    %w[G PG PG-13 R NC-17]
  end

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
