module EasyIMAP
  class Folder
    attr_reader :name

    def initialize(conn, name, delim)
      @conn = conn
      @full_name = name
      @name = name.split(delim).last
      @delim = delim
    end

    def messages
      @conn.examine(@full_name)
      @conn.uid_search(['ALL']).map do |uid|
        Message.new(@conn, uid)
      end
    end

    def folders
      @conn.list("#{@full_name}#{@delim}", '%').map do |f|
        Folder.new(@conn, f.name, f.delim)
      end
    end
  end
end
