module ApplicationHelper
  def api_response message, code
    render json: {message: message}, status: code
  end
end
