require 'date'
require_relative '../../models/student/student.rb'
require_relative './edit_student_presenter'

# == Edit_contacts_presenter
# Презентер для редактирования контактной информации студента.
class Edit_contacts_presenter < Edit_student_presenter

  # Заполнение полей интерфейса текущими контактами студента.
  def populate_fields
    self.get_student
    data = {
      "telegram" => self.student.telegram,
      "email" => self.student.email,
      "phone_number" => self.student.phone_number,
    }
    self.view.update_view data
  end

  # Проверка валидности контактных данных студента.
  #
  # @param student_data [Hash] Контактные данные студента.
  # @return [Boolean] Возвращает true, если данные валидны.
  def valid_data?(student_data)
    data = student_data.transform_values { |value| value.strip }
    self.logger.debug "Проверка валидности данных: #{data.to_s}"
    valid = Student.valid_phone_number?(data["phone_number"]) && Student.valid_email?(data["email"]) &&
      Student.valid_telegram?(data["telegram"])
    unchanged = self.student.telegram == data["telegram"] &&
      self.student.email == data["email"] &&
      self.student.phone_number == data["phone_number"]
    res = valid && !unchanged
    self.logger.info "Валидность данных: #{res}"
    res
  end
end