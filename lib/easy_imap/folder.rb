module EasyIMAP
  # A Folder on the IMAP server.
  class Folder
    # the name of the folder.
    attr_reader :name

    # Creates an instance representing a folder with +name+, on
    # the server connection +conn+, with the folder delimiter +delim+.
    #
    # Normally this class is only instantiated internally.
    def initialize(conn, name, delim)
      @conn = conn
      @full_name = name
      @name = name.split(delim).last
      @delim = delim
    end

    # An array of messages in this folder.
    def messages
      @conn.examine(@full_name)
      @conn.uid_search(['ALL']).map do |uid|
        Message.new(@conn, uid)
      end
    end

    # An array of folders in this folder.
    def folders
      @conn.list("#{@full_name}#{@delim}", '%').map do |f|
        Folder.new(@conn, f.name, f.delim)
      end
    end
  end
end
