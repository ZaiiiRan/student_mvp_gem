require 'logger'

# == App_logger
# Логгер приложения
class App_logger
  private_class_method :new

  # Инициализация объекта логгера.
  #
  # @param [String] file_path - путь к файлу логов.
  # @raise [Error] Не указан путь к файлу логов.
  def initialize(file_path)
    if file_path.nil? || file_path.empty?
      raise Error, 'Не указан путь к файлу логов'
    end
    self.file_path = file_path
    ensure_log_directory
    self.logger = Logger.new(self.file_path)
    self.logger.formatter = proc do |severity, datetime, progname, msg|
      "[#{datetime}] #{severity}: #{msg}\n"
    end
    setup_log_level
  end

  # Получение или создание объекта логгера
  # Путь задать достаточно всего один раз. Если он не задан перед первым использованием логгера, то выбрасывается исключение.
  # 
  # @param [String, nil] file_path - путь к файлу логов.
  # @raise [Error] Не указан путь к файлу логов.
  # @return [App_logger] - объект логгера.
  def self.instance(file_path = nil)
    @instance ||= new(file_path)
  end

  # Запись сообщения в лог
  #
  # @param [Symbol] severity - тип сообщения
  # @param [String] message - сообщение
  def log(severity, message)
    self.logger.send(severity, message)
  end


  # Запись информационного сообщения в лог
  #
  # @param [String] message - сообщение
  def info(message)
    log(:info, message)
  end

  # Запись сообщения для дебага в лог
  #
  # @param [String] message - сообщение
  def debug(message)
    log(:debug, message)
  end

  # Запись сообщения ошибки в лог
  #
  # @param [String] message - сообщение
  def error(message)
    log(:error, message)
  end

  # Запись сообщения предупреждения в лог
  #
  # @param [String] message - сообщение
  def warn(message)
    log(:warn, message)
  end

  # Запись сообщения фатальной ошибки в лог
  #
  # @param [String] message - сообщение
  def fatal(message)
    log(:fatal, message)
  end

  private
  attr_accessor :logger, :file_path

  def ensure_log_directory
    log_directory = File.dirname(self.file_path)
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
