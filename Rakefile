require 'rubygems'
gem 'hoe', '>= 2.1.0'
require 'hoe'
require 'fileutils'
require './lib/easy_imap'

Hoe.plugin :newgem
Hoe.plugin :website

# Generate all the Rake tasks
# Run 'rake -T' to see list of generated tasks (from gem root directory)
$hoe = Hoe.spec 'easy_imap' do
  self.developer 'Paul Stadig', 'paul@stadig.name'
  #self.changes              = self.paragraphs_of("History.txt", 0..1).join("\n\n")
  self.post_install_message = 'PostInstall.txt'
  self.rubyforge_name       = 'easy-imap'
  self.extra_deps         = [
    ['tmail','>= 1.2.3.1'],
  ]
  #self.extra_dev_deps = [
  #  ['newgem', ">= #{::Newgem::VERSION}"]
  #]

  #self.clean_globs |= %w[**/.DS_Store tmp *.log]
  #path = self.rubyforge_name
  #self.remote_rdoc_dir = File.join(path.gsub(/^#{self.rubyforge_name}\/?/,''), 'rdoc')
  #self.rsync_args = '-av --delete --ignore-errors'
end

require 'newgem/tasks'
Dir['tasks/**/*.rake'].each { |t| load t }

remove_task :default
task :default => [:spec, :features]
