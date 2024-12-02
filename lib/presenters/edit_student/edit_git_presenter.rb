require_relative '../../models/student/student.rb'
require_relative './edit_student_presenter'

# == Edit_git_presenter
# Презентер для редактирования информации о GitHub аккаунте студента.
class Edit_git_presenter < Edit_student_presenter

  # Заполнение полей интерфейса текущими данными о Git студента.
  def populate_fields
    self.get_student
    data = {
      "git" => self.student.git,
    }
    self.view.update_view data
  end

  # Проверка валидности данных о Git.
  #
  # @param student_data [Hash] Данные о Git.
  # @return [Boolean] Возвращает true, если данные валидны.
  def valid_data?(student_data)
    data = student_data.transform_values { |value| value.strip }
    self.logger.debug "Проверка валидности данных: #{data.to_s}"
    res = Student.valid_git?(data["git"]) && self.student.git != data["git"]
    self.logger.info "Валидность данных: #{res}"
    res
  end
end