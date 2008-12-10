require 'net/imap'

module EasyIMAP
  class Server
    def self.connect(host, options = nil)
      conn = Server.new(host, options)
      if block_given?
        yield conn
        conn.close
      end
    end

    def initialize(host, options = nil)
      options ||= {}
      @host = host
      @conn = Net::IMAP.new(host)#, options[:port])
      @conn.authenticate(options[:auth_type] || "LOGIN", options[:username], options[:password])
    end

    def folders
      @conn.list('', '%').map do |f|
        Folder.new(@conn, f.name, f.delim)
      end
    end

    def close
      @conn.disconnect
    end
  end
end
