postgresql_user node['django']['postgresql']['user'] do
  superuser false
  createdb false
  login true
  replication false
  password node['django']['postgresql']['password']
end

postgresql_database node['django']['postgresql']['database'] do
  owner node['django']['postgresql']['user']
  encoding "UTF-8"
  template "template0"
  locale "en_US.UTF-8"
end
