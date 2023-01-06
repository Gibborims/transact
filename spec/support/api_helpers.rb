module ApiHelpers
  def json
    JSON.parse(response.body)
  end

  def success
    "000"
  end

  def fail
    "101"
  end
end
