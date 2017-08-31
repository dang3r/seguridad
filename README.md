# Seguridad

## Overview

A library and CLI for extracting metadata information about TLS certificates

## Usage

### CLI

```
seguridad <host>[:port]...

$ ./seguridad google.ca bing.ca
google.ca
        Name: google.com
        Issuer: /C=US/O=Google Inc/CN=Google Internet Authority G2
        Not Before: 2017-08-22 16:52:59 UTC
        Not After: 2017-11-14 16:30:00 UTC
        Version: 2

bing.ca
        Name: www.bing.com
        Issuer: /C=US/ST=Washington/L=Redmond/O=Microsoft Corporation/OU=Microsoft IT/CN=Microsoft IT TLS CA 5
        Not Before: 2017-07-20 17:47:08 UTC
        Not After: 2019-07-10 17:47:08 UTC
        Version: 2
```

### Lib

```
#!/usr/bin/env ruby

require 'seguridad'

get_cert_info('google.ca')
```
