gem 'tmail'
require 'tmail'
require 'time'

module EasyIMAP
  class Message
    def initialize(conn, uid)
      @conn = conn
      @uid = uid
    end

    # The date this message was sent (an instance of Time).
    def date
      Time.parse(envelope[:date])
    end

    # The subject of this message.
    def subject
      envelope[:subject]
    end

    # An array of from e-mail addresses (as Strings).
    def from
      (envelope[:from] || []).map {|a| address(a)}
    end

    # An array of sender e-mail addresses (as Strings).
    def sender
      (envelope[:sender] || []).map{|a| address(a)}
    end

    # An array of reply_to e-mail addresses (as Strings).
    def reply_to
      (envelope[:reply_to] || []).map{|a| address(a)}
    end

    # An array of to e-mail addresses (as Strings).
    def to
      (envelope[:to] || []).map {|a| address(a)}
    end

    # An array of cc e-mail addresses (as Strings).
    def cc
      (envelope[:cc] || []).map {|a| address(a)}
    end

    # An array of bcc e-mail addresses (as Strings).
    def bcc
      (envelope[:bcc] || []).map {|a| address(a)}
    end

    # The in_reply_to attribute (as a String).
    def in_reply_to
      envelope[:in_reply_to]
    end

    # Returns true if this message is a multipart message.
    def multipart?
      body.multipart?
    end

    # Returns the text/plain portion of this message
    # (which could be the body, or one of the parts
    # if the message is multipart), or the empty
    # string if there is no text/plain portion.
    def text
      text = find_part("text/plain")
      text ? text.body : ""
    end

    # Returns the text/html portion of this message
    # (which could be the body, or one of the parts
    # if the message is multipart), or the empty
    # string if there is no text/html portion.
    def html
      html = find_part("text/html")
      html ? html.body : ""
    end

    # An array of Attachment instances if this
    # message is a multipart message with
    # attachments, or an empty array otherwise.
    def attachments
      @attachments ||= if body.multipart?
        body.parts.find_all{|p| p.disposition == "attachment"}.map{|a| Attachment.new(a)}
      else
        []
      end
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

    def body
      @body ||= TMail::Mail.parse(@conn.uid_fetch(@uid, "BODY[]").first.attr["BODY[]"])
    end

    def find_part(mime_type)
      if !body.multipart? && body.content_type == mime_type
        body
      elsif body.multipart?
        body.parts.find{|p| p.content_type == mime_type}
      end
    end
  end
end
