class TimeService
  FORMATS = {
    year: '%Y',
    month: '%m',
    day: '%d',
    hour: '%H',
    minute: '%M',
    second: '%S'
  }

  attr_reader :unkown_formats

  def initialize(time, formats)
    @time = time
    @formats = formats || ''
    @response_format = []
    @unkown_formats = []
  end

  def call
    @formats.split(',').each do |format|
      FORMATS[format.to_sym] ? @response_format << FORMATS[format.to_sym] : @unkown_formats << format
    end
  end

  def result
    ordered = []

    %w(%Y %m %d %H %M %S).each do |f|
      ordered << f if @response_format.include?(f)
    end

    @time.strftime(ordered.join('-'))
  end

  def valid_format?
    unkown_formats.empty?
  end
end
