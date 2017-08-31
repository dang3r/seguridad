#!/usr/bin/env ruby

require 'OpenSSL'
require 'socket'

class OpenSSL::X509::Certificate
    attr_accessor :domain

    def to_s
        [
            domain,
            "\tName: #{subject.to_s.match(/\/CN=[^\s]*/).to_s.split("=")[1]}",
            "\tIssuer: #{issuer}",
            "\tNot Before: #{not_before}",
            "\tNot After: #{not_after}",
            "\tVersion: #{version}"
        ].join("\n")
    end
end

# Return a monkey-patched X509 certificate for the given domain
def get_cert_info(domain)
    port = 443
    tokens = domain.split(':')
    if tokens.length > 1
        domain = tokens[0]
        port = tokens[-1].to_i
    end
    socket = TCPSocket.new(domain, port)
    ctx = OpenSSL::SSL::SSLContext.new
    tls = OpenSSL::SSL::SSLSocket.new(socket, ctx)
    tls.connect
    cert = OpenSSL::X509::Certificate.new tls.peer_cert
    cert.domain = domain
    cert
end
