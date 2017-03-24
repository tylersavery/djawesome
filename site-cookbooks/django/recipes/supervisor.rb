include_recipe 'supervisor'
log 'Creating supervisor django task'

cmd = node['python']['venv_dir'] +  'bin/python ' +  node['django']['app']['project_home'] + '/manage.py runserver 0.0.0.0:' +  node['django']['app']['port'] + ' --settings=' + node['django']['app']['settings'] 

django_env = {}

if node['django']['app']['pythonpath'] != nil
  django_env = {'PYTHONPATH' => node['django']['app']['pythonpath']}
end

supervisor_service 'djangoapp' do
  environment django_env
  command cmd
  user 'root'
  redirect_stderr true
  stdout_logfile '/var/log/djangoapp.log'
  autostart true
  autorestart true
  startsecs 10
  stopwaitsecs 600
  startretries 10
  action :enable
  
end  
