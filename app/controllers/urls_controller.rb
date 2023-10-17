class UrlsController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :create, :stats]

  def index
    @urls = Url.all
  end

  def redirect
    url = Url.find_by(short_url: params[:short_url])

    if url
      Click.create(url: url)
      redirect_to url.original_url
    else
      redirect_to root_path, notice: 'URL not found.'
    end
  end

  def new
    @url = Url.new
  end

  def create
    @url = Url.new(url_params)
    @url.user = current_user
    if @url.save
      redirect_to url_stats_path(@url), notice: 'URL created successfully.'
    else
      render :new
    end
  end

  def stats
    @url = Url.find(params[:id])
    @clicks = @url.clicks
  end

  def cleanup_expired
    expired_urls = Url.expired
    expired_urls.destroy_all

    redirect_to root_path, notice: 'Expected URLS have been cleared'
  end

  def url_params
    params.require(:url).permit(:original_url, :short_url)
  end
end
