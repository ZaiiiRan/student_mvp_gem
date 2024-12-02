require_relative '../../logger/logger.rb'

# == Edit_student_presenter
# Базовый класс для управления данными студентов. 
# Предоставляет общие методы для редактирования информации о студентах.
class Edit_student_presenter

  # Инициализация презентера для управления данными студентов.
  # 
  # @param view [Modal_interface] Представление для взаимодействия с пользователем.
  # @param parent_presenter [Student_list_presenter] Родительский презентер для управления общим контекстом.
  def initialize(view, parent_presenter)
    self.view = view
    self.parent_presenter = parent_presenter
    self.logger = App_logger.instance
  end

  # Основная операция редактирования студента.
  #
  # @param student_data [Hash] Данные студента.
  def operation(student_data)
    begin
      self.logger.debug "Создание объекта студента: #{student_data.to_s}"
      new_student(student_data)
      self.parent_presenter.replace_student(self.student)
      self.view.close
    rescue => e
      error_msg = "Ошибка при изменении студента: #{e.message}"
      self.logger.error error_msg
      self.view.show_error_message(error_msg)
    end
  end

  # Создание нового объекта студента из предоставленных данных.
  #
  # @param student_data [Hash] Данные студента.
  def new_student(student_data)
    data = student_data.transform_values do |value|
      stripped = value.strip
      stripped.empty? ? nil : stripped
    end

    attributes = self.get_attributes
    data.each do |key, value|
      attributes[key.to_sym] = value
    end
    self.student = Student.new_from_hash(attributes)
  end

  # Получение данных студента из родительского презентера.
  # Загружает информацию о выбранном студенте.
  def get_student
    id = self.parent_presenter.get_selected[0]
    begin
      self.student = self.parent_presenter.get_student(id)
    rescue => e
      error_msg = "Ошибка при загрузке данных о студенте: #{e.message}"
      self.logger.error error_msg
      self.view.show_error_message(error_msg)
    end
  end

  # Заполнение полей интерфейса данными студента.
  #
  # @raise [NotImplementedError] Метод должен быть реализован в подклассе.
  def populate_fields
    raise NotImplementedError
  end

  # Проверка валидности данных студента.
  #
  # @param student_data [Hash] Данные студента.
  # @return [Boolean] Возвращает true, если данные валидны.
  def valid_data?(student_data)
    data = student_data.transform_values { |value| value.strip }
    Student.valid_name?(data["first_name"]) && Student.valid_name?(data["name"]) &&
      Student.valid_name?(data["patronymic"]) && Student.valid_birthdate?(data["birthdate"])
  end

  protected
  # @!attribute [rw] view
  #   @return [Modal_interface] Объект представления.
  # @!attribute [rw] parent_presenter
  #   @return [Parent_presenter] Родительский презентер.
  # @!attribute [rw] student
  #   @return [Student, nil] Объект студента.
  # @!attribute [rw] logger
  #   @return [App_logger] Логгер для записи событий.
  attr_accessor :view, :parent_presenter, :student, :logger

  private

  # Получение атрибутов из объекта студента.
  # 
  # @return [Hash] Атрибуты студента.
  def get_attributes
    {
      id: self.student&.id,
      first_name: self.student&.first_name,
      name: self.student&.name,
      patronymic: self.student&.patronymic,
      birthdate: self.student&.birthdate,
      git: self.student&.git,
      telegram: self.student&.telegram,
      email: self.student&.email,
      phone_number: self.student&.phone_number
    }
  end
end