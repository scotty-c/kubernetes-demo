class kubernetes_docker::install (

  $master_ip = $kubernetes_docker::master_ip,

  ) {

  package { 'device-mapper-libs':
    ensure => installed,
    }

  class { 'docker':
    tcp_bind    => 'tcp://127.0.0.1:4243',
    socket_bind => 'unix:///var/run/docker.sock',
    require => Package['device-mapper-libs']
    } ->

  file { '/kubeconfig':
    ensure => directory,
    group  => 'docker',
    mode   => '0770',
    } ->

  file { '/kubeconfig/master.json':
    ensure  => file,
    content => template('kubernetes_docker/master.json.erb'), 
    mode    => '0755',
    } ->

  file { '/root/docker-compose.yml':
    ensure  => file,
    content => template('kubernetes_docker/docker-compose.yml.erb'), 
    } ->
  
  docker_compose { kubernetes :
    ensure => present, 
    source => '/root',
    scale  => ['1', '1', '1']
    }	
}