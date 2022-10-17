require_relative '../service/time_service'

class TimMiddleware
  def initialize(app)
    @app = app
    @status = 200
  end

  def call(env)
    @request = Rack::Request.new(env)
    @formats = @request.params["format"]
    check_path
    @response = Rack::Response.new(time, @status, headers)
    @response.finish
  end
end

def check_path
  if @request.path == '/time'
    @status = 200
  else
    @status = 404
  end
end

def headers
  {'Content-type' => 'plain/text'}
end

def time
  time = Time.now
  time_format = TimeService.new(time, @formats)
  time_format.call

  if time_format.valid_format?
    time_format.result
  else
    @status = 400
    "Unknown format #{time_format.unkown_formats}"
  end
end
