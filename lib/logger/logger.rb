require 'logger'

class App_logger
  private_class_method :new

  def initialize(file_path)
    ensure_log_directory
    self.logger = Logger.new(file_path)
    self.logger.formatter = proc do |severity, datetime, progname, msg|
      "[#{datetime}] #{severity}: #{msg}\n"
    end
    setup_log_level
  end

  def self.instance(file_path = nil)
    @instance ||= new(file_path)
  end

  def log(severity, message)
    self.logger.send(severity, message)
  end

  def info(message)
    log(:info, message)
  end

  def debug(message)
    log(:debug, message)
  end

  def error(message)
    log(:error, message)
  end

  def warn(message)
    log(:warn, message)
  end

  def fatal(message)
    log(:fatal, message)
  end

  private
  attr_accessor :logger

  def ensure_log_directory
    log_directory = File.dirname(LOG_FILE_PATH)
    Dir.mkdir(log_directory) unless Dir.exist?(log_directory)
  end

  def setup_log_level
    log_mode = ENV['LOG_MODE'] || 'hybrid'

    case log_mode.downcase
    when 'all'
      self.logger.level = Logger::DEBUG
    when 'errors'
      self.logger.level = Logger::ERROR
    when 'hybrid'
      self.logger.level = Logger::INFO
    end
  end
end
