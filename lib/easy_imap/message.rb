gem 'tmail'
require 'tmail'
require 'time'

module EasyIMAP
  class Message
    def initialize(conn, uid)
      @conn = conn
      @uid = uid
    end

    def date
      Time.parse(envelope[:date])
    end

    def subject
      envelope[:subject]
    end

    def from
      (envelope[:from] || []).map {|a| address(a)}
    end

    def sender
      (envelope[:sender] || []).map{|a| address(a)}
    end

    def reply_to
      (envelope[:reply_to] || []).map{|a| address(a)}
    end

    def to
      (envelope[:to] || []).map {|a| address(a)}
    end

    def cc
      (envelope[:cc] || []).map {|a| address(a)}
    end

    def bcc
      (envelope[:bcc] || []).map {|a| address(a)}
    end

    def in_reply_to
      envelope[:in_reply_to]
    end

    def multipart?
      body.multipart?
    end

    def text
      text = find_part("text/plain")
      text ? text.body : ""
    end

    def html
      html = find_part("text/html")
      html ? html.body : ""
    end

    def attachments
      if body.multipart?
        body.parts.find_all{|p| p.disposition == "attachment"}.map{|a| Attachment.new(a)}
      else
        []
      end
    end

    def find_part(mime_type)
      if !body.multipart? && body.content_type == mime_type
        body
      elsif body.multipart?
        body.parts.find{|p| p.content_type == mime_type}
      end
    end

    def body
      @mail ||= TMail::Mail.parse(@conn.uid_fetch(@uid, "BODY[]").first.attr["BODY[]"])
    end

    private
    def address(a)
      if a[:name]
        "\"#{a[:name]}\" <#{a[:mailbox]}@#{a[:host]}>"
      else
        "#{a[:mailbox]}@#{a[:host]}"
      end
    end

    def envelope
      @conn.uid_fetch(@uid, "ENVELOPE").first.attr["ENVELOPE"]
    end
  end
end
