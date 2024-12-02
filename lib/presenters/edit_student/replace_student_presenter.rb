require 'date'
require_relative '../../models/student/student.rb'
require_relative './edit_contacts_presenter'

# == Replace_student_presenter
# Презентер для замены информации о студенте.
class Replace_student_presenter < Edit_student_presenter

  # Заполнение полей интерфейса текущими основными данными студента.
  def populate_fields
    self.get_student
    data = {
      "first_name" => self.student.first_name,
      "name" => self.student.name,
      "patronymic" => self.student.patronymic,
      "birthdate" => self.student.birthdate.strftime('%d.%m.%Y'),
    }
    self.view.update_view data
  end

  # Проверка валидности новых данных студента.
  #
  # @param student_data [Hash] Новые данные студента.
  # @return [Boolean] Возвращает true, если данные валидны и отличаются от текущих.
  def valid_data?(student_data)
    data = student_data.transform_values { |value| value.strip }
    self.logger.debug "Проверка валидности данных: #{data.to_s}"
    valid = super(data)
    unchanged = self.student.first_name == data["first_name"] &&
      self.student.name == data["name"] &&
      self.student.patronymic == data["patronymic"] &&
      self.student.birthdate.strftime('%d.%m.%Y') == data["birthdate"]
    res = valid && !unchanged
    self.logger.info "Валидность данных: #{res}"
    res
  end
end