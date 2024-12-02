require 'mysql2'

# == DB_client
# Клиент базы данных MySQL
class DB_client
    private_class_method :new

    # Инициализация объекта класса БД.
    #
    # @param [Hash] db_config - конфигурация базы данных.
    # @raise [Error] Не указана конфигурация базы данных.
    def initialize(db_config)
        raise 'Не указана конфигурация базы данных' unless db_config
        self.client = Mysql2::Client.new(db_config)
    end

    # Получение или создание объекта клиента базы данных.
    # Конфигурацию БД достаточно задать 1 раз.
    #
    # @param [Hash] db_config - конфигурация базы данных.
    # @raise [Error] Не указана конфигурация базы данных.
    # @return [Mysql2::Client] - объект клиента базы данных.
    def self.instance(db_config = nil)
        @instance ||= new(db_config)
    end

    # Выполнение SQL запроса.
    #
    # @param [String] query - SQL запрос.
    # @param [Array] params - массив параметров для SQL запроса (необязательно)
    # @return [Mysql2::Hash] - результат выполнения запроса.
    def query(query, params=[])
        self.client.prepare(query).execute(*params)
    end

    # Закрытие объекта клиента базы данных.
    #
    def close
        self.client.close
    end

    private
    attr_accessor :client
    @instance = nil
end