class UrlsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :index]

  def index
    cleanup_expired
    @urls = Url.all
  end

  def show
    url = Url.find_by(slug: params[:slug])

    if url
      url.increment!(:clicks)
      redirect_to url.original_url, allow_other_host: true
    else
      redirect_to root_path, notice: 'URL not found.'
    end
  end

  def new
    @url = Url.new
    @url.slug = SecureRandom.urlsafe_base64(6)
  end

  def create
    @url = Url.new(url_params)
    @url.user = current_user
    @url.expires_at = Time.now + 1.minute
    if @url.save
      redirect_to root_path, notice: 'URL created successfully.'
    else
      render :new
    end
  end

  def cleanup_expired
    expired_urls = Url.expired
    expired_urls.destroy_all
  end

  def url_params
    params.require(:url).permit(:original_url, :slug)
  end
end
