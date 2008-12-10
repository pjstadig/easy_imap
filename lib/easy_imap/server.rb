require 'net/imap'

module EasyIMAP
  # A connection to an IMAP server.
  class Server
    # Makes a connection to +host+ and returns an instance of Server.
    #
    # If given a block it will yield the Server instance to the
    # block, and then close the connection to the IMAP server
    # after the block has finished. Otherwise you must close the connection
    # yourself.
    def self.connect(host, options = nil)
      conn = Server.new(host, options)
      if block_given?
        begin
          yield conn
        ensure
          conn.close
        end
      end
    end

    def initialize(host, options = nil)
      options ||= {}
      @host = host
      @conn = Net::IMAP.new(host)#, options[:port])
      @conn.authenticate(options[:auth_type] || "LOGIN", options[:username], options[:password])
    end

    # Returns an array of Folder instances, one for each
    # root level folder on the server.
    def folders
      @conn.list('', '%').map do |f|
        Folder.new(@conn, f.name, f.delim)
      end
    end

    # Closes the connection to the IMAP server.
    def close
      @conn.disconnect
    end
  end
end
