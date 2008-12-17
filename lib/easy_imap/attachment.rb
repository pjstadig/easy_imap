module EasyIMAP
  class Attachment
    def initialize(body)
      @body = body
    end

    # The mime type of this attachment.
    def content_type
      @body.content_type
    end

    def filename
      @body.disposition_param("filename")
    end

    # The body of this attachment.
    def body
      @body.body
    end

    def to_s
      "<#{self.class}: @content_type='#{content_type}'>"
    end
    alias_method(:inspect, :to_s)
  end
end
