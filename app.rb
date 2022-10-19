class App
  def call(env)
    [status, headers, body]
  end

  private

  def status
    200
  end

  def headers
    {'Content-type' => 'plain/text'}
  end

  def body
    ['']
  end
end
