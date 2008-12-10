module EasyIMAP
  class Attachment
    def initialize(body)
      @body = body
    end

    def content_type
      @body.content_type
    end

    def body
      @body.body
    end

    def to_s
      "<#{self.class}: @content_type='#{content_type}'>"
    end
    alias_method(:inspect, :to_s)
  end
end
