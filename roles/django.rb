name 'django'
description 'Django workstation Role'
run_list('recipe[base]', 'recipe[postgresql::server]', 'recipe[postgresql::client]', 'recipe[django]')
default_attributes()
override_attributes()
