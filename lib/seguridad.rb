#!/usr/bin/env ruby

require 'OpenSSL'
require 'socket'

class OpenSSL::X509::Certificate
    # TODO : Fix
    def to_s
    end
    def print
        puts "\tName: #{subject.to_s.match(/\/CN=[^\s]*/).to_s.split("=")[1]}"
        puts "\tIssuer: #{issuer}"
        puts "\tNot Before: #{not_before}"
        puts "\tNot After: #{not_after}"
        puts "\tVersion: #{version}"
    end
end

def get_cert_info(domain)
    puts domain
    port = 443
    tokens = domain.split(':')
    if tokens.length > 1
        domain = tokens[0]
        port = tokens[-1].to_i
    end
    ctx = OpenSSL::SSL::SSLContext.new
    socket = TCPSocket.new(domain, port)

    tls = OpenSSL::SSL::SSLSocket.new(socket, ctx)
    tls.connect
    cert = OpenSSL::X509::Certificate.new tls.peer_cert
    cert.print
    puts
end
