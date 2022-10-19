require_relative 'middleware/time'
require_relative 'app'

use TimMiddleware
run App.new
