class Url < ApplicationRecord
  belongs_to :user
  validates :original_url, presence: true
  validates :slug, presence: true, uniqueness: true

  scope :expired, -> { where('expires_at < ?', Time.now) }


  def to_param
    slug
  end

  def shortened_url
    Rails.application.routes.url_helpers.url_for(:action => 'show', :controller => 'urls', :host => get_host, slug: self.slug)
  end


  private

  def get_host
    if Rails.env.production?
      "https://rails-uvl1.onrender.com/"
    else
      port = ENV.fetch("PORT") { 3000 }
      "http://localhost:#{port}"
    end

  end

end
