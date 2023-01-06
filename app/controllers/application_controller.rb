class ApplicationController < ActionController::API
  before_action :set_default_format

  SUCCESS_CODE = "000"
  FAIL_CODE = "101"

  private

  def set_default_format
    request.format = :json
  end
end
