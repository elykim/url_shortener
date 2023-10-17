class Url < ApplicationRecord
  before_create :generate_short_url
  belongs_to :user
  has_many :clicks
  validates :original_url, presence: true
  validates :short_url, presence: true, uniqueness: true

  scope :expired, -> { where('expiration_date < ?', Time.now) }

  def generate_short_url
    self.short_url = SecureRandom.urlsafe_base64(6)
  end
end
