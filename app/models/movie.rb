class Movie < ApplicationRecord
  has_many :reviews

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_past

  mount_uploader :image, ImageUploader

  # scope :title, -> (title) { where("title like ?", "#{title}%")}
  # scope :director, -> (director) { where("director like ?", "#{director}%")}

  def self.search(search)
    where("title LIKE ? OR director LIKE ?", "%#{search}%", "%#{search}%")
    # where("title LIKE ?", "%#{search}%").where("director LIKE ?", "%#{search}%")
  end

  def self.duration(duration)
    case duration
      when "Under 90 minutes"
        where("runtime_in_minutes < 90")
      when "Between 90 and 120 minutes"
        where("runtime_in_minutes Between 90 AND 120")
      when "Over 120 minutes"  
        where("runtime_in_minutes > 120")
    end
  end  

  def review_average
    if reviews.size > 0
      reviews.sum(:rating_out_of_ten)/reviews.size
    end  
  end

  protected

    def release_date_is_in_the_past
      if release_date.present?
        errors.add(:release_date, "should be in the past") if release_date > Date.today
      end
    end

end
