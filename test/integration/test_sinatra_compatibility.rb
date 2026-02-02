require 'test_helper'
require 'support/rails_app'
require 'support/delayed_job_fake'

class TestSinatraCompatibility < Minitest::Test
  include Rack::Test::Methods

  def app
    RailsApp
  end

  def test_csrf_token_is_set_in_session
    get '/delayed_job/overview'
    assert last_request.env['rack.session'][:csrf], "CSRF token should be set in session"
  end

  def test_post_without_csrf_token_is_rejected
    post '/delayed_job/failed/clear'
    assert_equal 403, last_response.status, "POST without CSRF token should be rejected"
  end
end
