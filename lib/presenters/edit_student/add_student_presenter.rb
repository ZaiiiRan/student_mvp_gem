require 'date'
require_relative '../../models/student/student.rb'
require_relative './edit_contacts_presenter'

# == Add_student_presenter
# Презентер для добавления нового студента.
class Add_student_presenter < Edit_student_presenter

  # Операция добавления нового студента.
  #
  # @param student_data [Hash] Данные студента.
  def operation(student_data)
    begin
      self.logger.debug "Создание объекта студента: #{student_data.to_s}"
      new_student(student_data)
      self.parent_presenter.add_student(self.student)
      self.view.close
    rescue => e
      error_msg = "Ошибка при добавлении студента: #{e.message}"
      self.logger.error error_msg
      self.view.show_error_message(error_msg)
    end
  end

  # Заполнение полей интерфейса пустыми данными для нового студента.
  def populate_fields
    data = {
    "first_name" => "",
    "name" => "",
    "patronymic" => "",
    "birthdate" => "",
  }
    self.view.update_view data
  end

  # Проверка валидности данных студента при добавлении.
  #
  # @param student_data [Hash] Данные студента.
  # @return [Boolean] Возвращает true, если данные валидны.
  def valid_data?(student_data)
    self.logger.debug "Проверка валидности данных: #{student_data.to_s}"
    res = super(student_data)
    self.logger.info "Валидность данных: #{res}"
    res
  end
end