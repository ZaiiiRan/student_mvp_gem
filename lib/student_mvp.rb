# frozen_string_literal: true

require_relative "student_mvp/version"
require_relative './presenters/base_presenters/base_presenter.rb'
require_relative './presenters/base_presenters/student_list_presenter.rb'
require_relative './presenters/edit_student/add_student_presenter.rb'
require_relative './presenters/edit_student/edit_contacts_presenter.rb'
require_relative './presenters/edit_student/edit_git_presenter.rb'
require_relative './presenters/edit_student/edit_student_presenter.rb'
require_relative './presenters/edit_student/replace_student_presenter.rb'
require_relative './data_access/DB_client/DB_client.rb'

module StudentMvp
  class Error < StandardError; end
  # Your code goes here...
end
