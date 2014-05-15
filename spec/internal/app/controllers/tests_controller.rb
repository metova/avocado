class TestsController < ActionController::Base
  def json
    render json: { test: true }
  end

  def text
    render text: 'test'
  end
end