module RequestHelpers
  def response_json(response)
    JSON.parse(response.body)
  end
end
