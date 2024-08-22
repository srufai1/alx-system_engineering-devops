# File:   7-puppet_install_nginx_web_server.pp
# Author: Suleman Rufai
# email:  <srufai100@gmail.com> or <ruftech24@gmail.com>

# Using Puppet| Install Nginx server, setup and configuration

package { 'nginx':
  ensure => 'installed'
}

file { '/var/www/html/index.html':
  content => 'Hello World',
}

file_line { 'redirection-301':
  ensure => 'present',
  path   => '/etc/nginx/sites-available/default',
  after  => 'listen 80 default_server;',
  line   => 'rewrite ^/redirect_me https://www.youtube.com/@srufai-Ing permanent;',
}

service { 'nginx':
  ensure  => running,
  require => Package['nginx'],
}