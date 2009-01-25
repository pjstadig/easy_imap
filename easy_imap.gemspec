# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{easy_imap}
  s.version = "0.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Paul Stadig"]
  s.date = %q{2009-01-25}
  s.description = %q{A simple interface to proccessing e-mail messages using IMAP, including handling multipart messages and attachments.}
  s.email = ["paul@stadig.name"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc"]
  s.files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "lib/easy_imap.rb", "lib/easy_imap/attachment.rb", "lib/easy_imap/folder.rb", "lib/easy_imap/message.rb", "lib/easy_imap/server.rb", "script/console", "script/destroy", "script/generate", "script/txt2html", "spec/easy_imap_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "tasks/rspec.rake"]
  s.has_rdoc = true
  s.homepage = %q{http://easy-imap.rubyforge.org/}
  s.post_install_message = %q{PostInstall.txt}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{easy-imap}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A simple interface to proccessing e-mail messages using IMAP, including handling multipart messages and attachments.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<tmail>, [">= 1.2.3.1"])
      s.add_development_dependency(%q<newgem>, [">= 1.2.3"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<tmail>, [">= 1.2.3.1"])
      s.add_dependency(%q<newgem>, [">= 1.2.3"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<tmail>, [">= 1.2.3.1"])
    s.add_dependency(%q<newgem>, [">= 1.2.3"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
