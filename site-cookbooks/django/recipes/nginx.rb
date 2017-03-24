log 'installing nginx'

package 'nginx'

log 'deleting default site'

bash 'delete_default_site' do
  user 'root'
  cwd "#{node['nt_nginx']['dir']}/sites-available"
  code <<-EOH
    service nginx stop
    rm -f default
EOH
  action :run
end
log 'costumizing nginx configuration'

template '/etc/nginx/nginx.conf'  do
  source 'nginx_conf.erb'
  mode '0755'
  owner 'root'
  group 'root'
end

log 'installing django site'

template "#{node['nt_nginx']['dir']}/sites-available/django" do
  source 'django_site.erb'
  mode '0755'
  owner node['nt_nginx']['user']
  group node['nt_nginx']['group']
end


bash 'enable_default_site' do
  user 'root'
  cwd "#{node['nt_nginx']['dir']}/sites-available"
  code <<-EOH
    rm -f #{node['nt_nginx']['dir']}/sites-enabled/django
    rm -f #{node['nt_nginx']['dir']}/sites-enabled/default
    ln -s #{node['nt_nginx']['dir']}/sites-available/django #{node['nt_nginx']['dir']}/sites-enabled/django
    service nginx start
EOH
  action :run
end



