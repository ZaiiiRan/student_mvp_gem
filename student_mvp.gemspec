# frozen_string_literal: true

require_relative "lib/student_mvp/version"

Gem::Specification.new do |spec|
  spec.name = "student_mvp"
  spec.version = StudentMvp::VERSION
  spec.authors = ["ZaiiiRan"]
  spec.email = ["a1b075753@gmail.com"]

  spec.summary = "Презентеры и модели для разработки приложения для работы со студентами."
  spec.description = "Содержит в себе модели и презентеры, логгер и класс клиента для СУБД MySQL, необходимые для разработки приложения для работы со студентами на основе паттерна MVP."
  spec.required_ruby_version = ">= 3.0.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'date'
  spec.add_runtime_dependency 'logger'
  spec.add_runtime_dependency 'json'
  spec.add_runtime_dependency 'yaml'
  spec.add_runtime_dependency 'mysql2'
  spec.add_runtime_dependency 'dotenv'

  spec.extra_rdoc_files = Dir.glob('doc/**/*')

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
