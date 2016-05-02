class kubernetes_docker::apps {

  kubernetes_run { 'nginx':
    image => 'nginx',
    port  => '80',
    require => Class['kubernetes_docker::config']
    }
}