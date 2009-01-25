require 'net/imap'

module EasyIMAP
  # A connection to an IMAP server.
  class Server
    # Makes a connection to +host+ and returns an instance of Server.
    #
    # It is recommended that you use this method to connect instead
    # of Server#new, because at some time in the future there may be
    # multiple server classes to smooth over "quirks" in IMAP
    # implementations.  This method should automatically select the
    # right server class for you.
    #
    # If given a block it will yield the Server instance to the
    # block, and then close the connection to the IMAP server
    # after the block has finished. Otherwise you must close the connection
    # yourself.
    #
    # Valid options are:
    # port:: the server port on which to connect (defaults to 143)
    # username:: the username with which to connect
    # password:: the password with which to connect
    # auth_type:: the authentication type with which to connect (defaults to LOGIN)
    # use_ssl:: if true, then use SSL to connect (defaults to false).
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
      @conn = Net::IMAP.new(host, options[:port] || 143, options[:use_ssl] || false)

      if options[:auth_type].to_s.downcase == "plain"
        @conn.login(options[:username], options[:password])
      else
        @conn.authenticate(options[:auth_type] || "LOGIN", options[:username], options[:password])
      end
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
