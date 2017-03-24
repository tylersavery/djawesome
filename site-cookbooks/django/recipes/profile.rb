log 'writing ~/.profile'

template '/home/vagrant/.profile' do
  source 'profile.erb'
  owner 'vagrant'
  group 'vagrant'
end
