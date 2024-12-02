require_relative '../../logger/logger.rb'

# == Base_presenter
# Базовый класс для презентеров.
# Управляет основными атрибутами и логикой взаимодействия между представлениями и данными.
class Base_presenter
  # Инициализация базового презентера.
  # 
  # @param view [Base_view_interface] Объект представления, с которым работает презентер.
  def initialize(view)
    self.view = view
    self.logger = App_logger.instance
  end
  
  protected

  # @!attribute [rw] view
  #   @return [Base_view_interface] Объект представления.
  # @!attribute [rw] entities_list
  #   @return [Students_list, nil] Список сущностей.
  # @!attribute [rw] data_list
  #   @return [Data_list, nil] Список данных.
  # @!attribute [rw] logger
  #   @return [App_logger] Логгер для записи событий.
  attr_accessor :view, :entities_list, :data_list, :logger
end