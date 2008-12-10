$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module EasyIMAP
  VERSION = '0.0.1'
end

require 'easy_imap/server'
require 'easy_imap/folder'
require 'easy_imap/message'
require 'easy_imap/attachment'
