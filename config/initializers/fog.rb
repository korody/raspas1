CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => 'AKIAJYBTFMGBKR2YOIDQ',       # required
    :aws_secret_access_key  => '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',       # required
    :region                 => 'sa-east-1'  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'raspas.images'                     # required
  config.fog_host       = false                                  # optional, defaults to true
end