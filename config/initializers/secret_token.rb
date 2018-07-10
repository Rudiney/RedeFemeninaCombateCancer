# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
secret = Rails.env.production? ? ENV['SECRET_TOKEN'] : "b5019af9a09ba6dfcaf9bb1e9b38bfc8117713257e1b94e0707a5aa7c6754294309b8cf9fa252a8945d9c59f8cae917433409f605c8c1f05088645c4cefb6a70"
RedeFeminina::Application.config.secret_token = secret
