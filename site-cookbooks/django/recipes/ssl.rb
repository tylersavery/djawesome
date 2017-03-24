defaults_ssl_listen = { 'ssl_listen' => '443'}

cert = defaults_ssl_listen.merge(Chef::DataBagItem.load('ssl_certs', node['ssl_certificates']['cert_items']))
ssl_conf = {
    :crt_path => File.join(node['ssl_certificates']['cert_dir'], "#{cert['id']}.crt"),
    :key_path => File.join(node['ssl_certificates']['key_dir'], "#{cert['id']}.key"),
    :pem_path => File.join(node['ssl_certificates']['key_dir'], "#{cert['id']}.pem"),
}
ssl_conf.merge!(cert)

node.set['ssl_certificates']['ssl_conf']['crt_path'] = ssl_conf[:crt_path]
node.set['ssl_certificates']['ssl_conf']['key_path'] = ssl_conf[:key_path]
node.set['ssl_certificates']['ssl_conf']['pem_path'] = ssl_conf[:pem_path]

template ssl_conf[:crt_path] do
  source 'ssl.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables(:content => ssl_conf['cert'].join("\n"))
end

template ssl_conf[:key_path] do
  source 'ssl.erb'
  owner 'root'
  group 'root'
  mode 0600
  variables(:content => ssl_conf['key'].join("\n"))
end

template ssl_conf[:pem_path] do
  source 'ssl.erb'
  owner 'root'
  group 'root'
  mode 0600
  variables(
      :content => (ssl_conf['cert'] << ssl_conf['key']).flatten.join("\n")
  )
end

