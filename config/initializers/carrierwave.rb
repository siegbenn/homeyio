CarrierWave.configure do |config|

  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => 'AKIAIKADMPZAZ5LHR4HA',                        # required
    :aws_secret_access_key  => '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',                        # required
  }
  config.fog_directory  = 'homey'                     # required
  config.fog_public     = true                                   # optional, defaults to true
end