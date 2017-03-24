default['ssl_certificates']['cert_items'] = 'star_nt_dev'
default['ssl_certificates']['cert_dir'] = '/etc/ssl/certs'
default['ssl_certificates']['key_dir'] = '/etc/ssl/private'


# Nginx Overrides

default['nginx']['ssl_only'] = false
default['nginx']['ssl_protocols'] = 'TLSv1.2 TLSv1.1 TLSv1'

default['nginx']['ssl_prefer_server_ciphers'] = 'on'
default['nginx']['ssl_session_cache'] = 'shared:SSL:10m'



default['nt_nginx']['gzip_types'] = "gzip_types text/plain text/css application/pdf application/json application/javascript application/x-javascript text/javascript text/xml application/xml application/rss+xml application/atom+xml application/rdf+xml image/svg+xml application/vnd.ms-fontobject application/x-font-ttf font/opentype"

default['nt_nginx']['worker_processes'] = 2
default['nt_nginx']['ssl_session_timeout'] = '11m'
default['nt_nginx']['ssl_ciphers'] = 'ECDH+AESGCM:DH+AESGCM:ECDH+AES256:DH+AES256:DH+AES:ECDH+3DES:DH+3DES:RSA+AES:RSA+3DES:!ADH:!AECDH:!MD5:!DSS:!MEDIUM'
default['nt_nginx']['gzip_buffers'] = '128 4k'
default['nt_nginx']['gzip_vary'] = 'on'
default['nt_nginx']['gzip_proxied'] = 'any'
default['nt_nginx']['gzip_comp_level'] = '6'
default['nt_nginx']['gzip_http_version'] = '1.0'
default['nt_nginx']['gzip'] = 'on'
default['nt_nginx']['keepalive_timeout'] = 80
default['nt_nginx']['pid'] = 'nt_nginx.pid'
default['nt_nginx']['worker_connections'] = 1024
default['nt_nginx']['dir'] = '/etc/nginx'
default['nt_nginx']['user'] = 'www-data'
default['nt_nginx']['group'] = 'www-data'
