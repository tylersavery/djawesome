include_recipe "django::postgresql"
include_recipe "django::python"
include_recipe "django::ssl"
include_recipe "django::nginx"
include_recipe "django::gunicorn"
include_recipe "django::profile"


log 'creating log directory'

directory node['django']['log_dir'] do
  owner "root"
  group "root"
  mode 00644
  action :create
end
