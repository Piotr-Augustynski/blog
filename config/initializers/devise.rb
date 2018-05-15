Devise.setup do |config|
  config.secret_key = 'b8c7d2d0e57b39bbbd1f461f80beeb196bce8f428e2bc844287fcab76716b5f851f635b93eaa90cdd75eae8c737c57ab52a76197ce8501d3b165ae4b24f807a6'

  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]

  config.strip_whitespace_keys = [:email]

  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 11

  config.reconfirmable = true

  config.expire_all_remember_me_on_sign_out = true

  config.password_length = 6..128

  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  config.reset_password_within = 6.hours

  config.sign_out_via = :delete
end
