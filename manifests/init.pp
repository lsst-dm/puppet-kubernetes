# kubernetes
#
# Install a basic implementation of kubernetes
# Eventually we may consider replacing with https://forge.puppet.com/puppetlabs/kubernetes
#
# @summary Install a basic implementation of kubernetes
#
# @example
#   include kubernetes
#
#   Parameters
#       - version : String : Preferred version of kubernetes to install, e.g.  '1.8.5-0'
#                            If not specified, defaults to 'present' and will
#                            install the latest version
class kubernetes (
    Hash[String,String,1] $yumrepo_data,
    Array[String,1]       $required_pkgs,
    String                $version,
) {

    yumrepo { 'kubernetes' :
        ensure  => present,
        descr   => 'Kubernetes',
        enabled => 1,
        protect => 0,
        *       => $yumrepo_data,
    }

    # Required packages
    ensure_packages( $required_pkgs, { 'ensure'  => $version } )

#    # FUTURE CONFIGS
#    # CHANGE systemd TO cgroupfs
#    file { '/etc/systemd/system/kubelet.service.d':
#        ensure => 'directory',
#        owner  => 'root',
#        group  => 'root',
#        mode   => '700',
#    }
#
#    file { '/etc/systemd/system/kubelet.service.d/10-kubeadm.conf':
#        ensure => 'file',
#        source => "puppet:///modules/elastic/etc/systemd/system/kubelet.service.d/10-kubeadm.conf",
#        owner => 'root',
#        group => 'root',
#        mode => '755',
#        require => [
#            File['/etc/systemd/system/kubelet.service.d'],
#        ],
#        notify    => Service['kubelet'],
#    }
#
#    # SET IPTABLES FOR BRIDGING
#    exec { 'set iptables for bridging':
#        unless => 'cat /proc/sys/net/bridge/bridge-nf-call-iptables | grep 1',
#        command => 'echo "1" > /proc/sys/net/bridge/bridge-nf-call-iptables',
#        path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
#        notify    => Service['kubelet'],
#    }
#
#    # ENABLE AND START KUBELET
#    service { 'kubelet':
#        ensure => running,
#        enable => true,
#        hasstatus => true,
#        hasrestart => true,
#        require => [
#            File['/etc/systemd/system/kubelet.service.d/10-kubeadm.conf'],
#        ],
#    }

}
