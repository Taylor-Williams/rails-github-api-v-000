class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.body = { 'client_id': ENV['GITHUB_CLIENT_ID'],
        'client_secret': ENV['GITHUB_CLIENT_SECRET'], 'code': code }
      req.headers['Accept'] = 'application/json'
    end
    body = JSON.parse(response.body)
    session['access_token'] = body['access_token']
  end
end
