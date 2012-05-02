if Rails.env.test? # Store the files locally for test environment
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
end

if Rails.env.development? or Rails.env.production? # Using Amazon S3 for Development and Production
  CarrierWave.configure do |config|
    config.root = Rails.root.join('tmp')
    config.cache_dir = 'uploads'

    config.fog_credentials = {
      :provider               => 'AWS',       # required
      :aws_access_key_id      => 'AKIAJYBTFMGBKR2YOIDQ',       # required
      :aws_secret_access_key  => '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',       # required
      :region                 => 'sa-east-1'  # optional, defaults to 'us-east-1'
    }
    config.fog_directory  = 'raspas.images'                     # required
    config.fog_host       = false                                  # optional, defaults to true
  end
end
