# django-vagrant-chef #


# Quick Start #

```
cd project
vagrant up
vagrant ssh
pip_install
dj_migrate
dj_create_super
dj_collectstatic
dj_server
```
Then, visit `http://localhost:8888` in host machine's web broswer

Chef recipes to provisioning a django stack on vagrant:

* Python virtualenv.

* Postgresql

* Gunicorn with upstart


# Operative systems supported #

* Ubuntu 14.04

* Debian family with upstart support

Note: Debian with System V is not supported by these chef recipes.


## Vagrant plugins ##

Install the next vagrant plugins before provisioning your box:

* vagrant plugin install vagrant-omnibus  
* vagrant plugin install vagrant-librarian-chef


## Roles ##
The *django* role run all the recipes required to deploy a django devbox, you will need to add
it to the vagrant configuration:


```ruby


....

config.vm.provision "chef_solo" do |chef|
    ...

    chef.add_role('django')

    ...
end

....

```


## Environments ##

Instead of modifing default attributes, these cookbooks use chef enviroments feature, all
configuration values are defined in environments/django.json , in order to pass these parameters to
vagrant is required to speciy enviroment directory inside vagrant configuration file:


```ruby

....

config.vm.provision "chef_solo" do |chef|
    ...

    chef.environments_path = '../environments'

    ...
end

....

```



## Cookbooks ##

### Base ###

Install packages required to setup a django debian box, you don't need to set up special
attributes


### Postgresql ##


Postresql server and client recipes from phlipper https://github.com/phlipper/chef-postgresql are used
to setting up dajngo vagrant box. All we have to do is specify configuration params on environments/django.json

```
      "postgresql" : {
        "password" : {
          "postgres" : "randompassisbetter"
        },
        "pg_hba" : [
          {"type" : "local", "db": "all" , "user": "postgres", "addr" : "", "method" : "ident" },
          {"type" : "local", "db": "django", "user" : "django", "method" : "md5" }
        ]
      }
```


### Django ###

Recipes that install postgresql, python, nginx and gunicorn. Attributes should be described on
enviroments/django.json file.

Postgresql app db configuration:

```
  "django": {

        ...

        "postgresql" : {
          "database" : "django",
          "user": "django",
          "password" : "django",
          "encoding" : "UTF-8"
        }

        ...
  }
```


SSl configuration:

```
    "ssl_certificates": {
          "cert_items": "star_nt_dev"
      }
```


Python virtualenv configuration, add all your python dependencies here:

```
  "django": {

       ...

       "python": {
          "packages": ["django", "gunicorn"],
          "venv_dir" : "/opt/env/",
          "username": "vagrant",
          "gid": "vagrant"
        }


        ...
  }
```


Log file configuration:

```

  "django": {

       ...

       "log_dir": "/var/log/notempo"

       ...
  }
```


Gunicorn configuration:

```
  "django": {

       ...

       "gunicorn": {
          "working_dir": "/djanto/testproject",
          "port": "26456",
          "workers": 2,
          "timeout": 60,
          "settings": "testproject.settings",
          "app": "ds3"
        }
```


Nginx configuration:

```
  "django": {

       ...

        ,
        "nginx": {
          "server_name": "django.io",
        },
 ,
        "ssl": {
          "cert_name": "star_nt_dev"
        },
      },

    }
```






Vagrantfile configuration
--------------------------
```ruby
config.omnibus.chef_version = :latest
config.librarian_chef.cheffile_dir = '~/src/django-vagrant-chef'

config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = "~/src/django-vagrant-chef/cookbooks"
    chef.roles_path = "~/src/django-vagrant-chef/roles"
    chef.data_bags_path = "~/src/YOUR_DIRECTORY/data_bags"
    chef.add_role('django')
end
```



Example
----------------

Inside test directory there is a Vagrant file example and a django app example



License and Author
==================

- Author:: Manuel Ignacio Franco (<maigfrga@gmail.com>)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
