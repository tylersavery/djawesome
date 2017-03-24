include_recipe 'python'

log 'Installing virtualenv packages'

%w{libcrack2-dev libpq-dev libcurl4-openssl-dev python-dev libevent-dev}.each do |pkg|
  package pkg do
      action :install
  end
end


directory node['django']['python']['venv_dir'] do
  owner node['django']['python']['username']
  group node['django']['python']['gid']
  mode '0744'
  action :create
end

virtualenv_dir = node['django']['python']['venv_dir'] + '.django'

python_virtualenv virtualenv_dir do
  interpreter "python2"
  owner node['django']['python']['username']
  group node['django']['python']['gid']
  action :create
end


node['django']['python']['packages'].each do |pkg, version|
  python_pip pkg.to_s do
    version version
    virtualenv virtualenv_dir
  end
end
