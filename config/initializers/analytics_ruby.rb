Analytics = AnalyticsRuby       # Alias for convenience
Analytics.init({
    secret: 'kxul6zk21u',          # The write key for bennettesiegel/homey
    on_error: Proc.new { |status, msg| print msg }  # Optional error handler
})