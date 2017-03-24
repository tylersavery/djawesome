log 'installing django gunicorn'


log 'copying gunicorn configuration'

template "/etc/init/ds3.conf" do
  source 'ds_gunicorn.erb'
  mode '0755'
  owner 'root'
  group 'root'
end


bash 'enable_gunicorn_script' do
  user 'root'
  code <<-EOH
    ln -fs /lib/init/upstart-job /etc/init.d/gunicorn
    update-rc.d gunicorn defaults
    service nginx restart
EOH
  action :run
end


bash 'start_gunicorn' do
  user 'root'
  code <<-EOH
    service ds3 start
EOH
  action :run
end
