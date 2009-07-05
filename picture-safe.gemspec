# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{picture-safe}
  s.version = "0.0.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jack Russell Software Company, LLC"]
  s.date = %q{2009-07-05}
  s.default_executable = %q{psafe}
  s.email = %q{picture-safe@jackhq.com}
  s.executables = ["psafe"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "bin/psafe",
     "lib/picture-safe.rb",
     "lib/picture-safe/command.rb",
     "lib/picture-safe/commands/backup.rb",
     "lib/picture-safe/commands/base.rb",
     "lib/picture-safe/commands/help.rb",
     "picture-safe.gemspec",
     "readme",
     "spec/base.rb",
     "spec/command_spec.rb",
     "spec/commands/backup_spec.rb",
     "spec/commands/base_spec.rb",
     "spec/commands/help_spec.rb",
     "spec/picture-safe_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/twilson63/picture-safe}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{Picture Safe is a gem that backs up all the jpeg's in a given directory and its sub directory.}
  s.test_files = [
    "spec/base.rb",
     "spec/command_spec.rb",
     "spec/commands/backup_spec.rb",
     "spec/commands/base_spec.rb",
     "spec/commands/help_spec.rb",
     "spec/picture-safe_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
