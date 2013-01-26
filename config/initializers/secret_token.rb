# Be sure to restart your server when you modify this file.

retried = false
secret_token = nil
# Store the secret token in a file that is not committed to git
secret_token_pathname = Rails.root.join('config', 'secret_token')

begin
  secret_token_pathname.open('r') do |f|
    secret_token = f.read
  end
# generate a secret token and write it to the file if the file does not exist
rescue Errno::ENOENT
  if retried
    raise
  end

  # same thing `rake secret` does
  secret_token = SecureRandom.hex(64)

  secret_token_pathname.open('w') do |f|
    f.write(secret_token)
  end

  # set flag so this doesn't get stuck in a loop
  retried = true
  # retry to ensure the file is readable
  retry
end

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
Underdork::Application.config.secret_token = secret_token
