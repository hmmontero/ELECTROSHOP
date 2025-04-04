class UploadsController < ApplicationController
  def sign
    timestamp = Time.now.to_i
    signature = Cloudinary::Utils.api_sign_request({ timestamp: timestamp }, Cloudinary.config.api_secret)
    render json: {
      cloud_name: Cloudinary.config.cloud_name,
      api_key: Cloudinary.config.api_key,
      timestamp: timestamp,
      signature: signature
    }
  end

  def new
  end
end
