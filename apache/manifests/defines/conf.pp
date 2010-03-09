# Define apache::conf
#
# General apache main configuration file's inline modification define
# Use with caution, it doesn't fit well with Apache's conf logic based on containers
# Use just for ALREADY DEFINED general settings in main httpd.conf
#
# Usage:
# apache::conf    { "KeepAlive":  value => "On" }

define apache::conf ($value) {

        config { "apache_conf_$name":
                file      => $operatingsystem ?{
                                freebsd => "/usr/local/etc/apache20/httpd.conf",
                                ubuntu  => "/etc/apache2/apache2.conf",
                                debian  => "/etc/apache2/apache2.conf",
                                centos  => "/etc/httpd/conf/httpd.conf",
                                redhat  => "/etc/httpd/conf/httpd.conf",
                             },
                line      => "$name $value",
                pattern   => "$name ",
                engine    => "replaceline",
                notify    => Service["apache"],
                require   => File["httpd.conf"],
                source    => "apache::conf",
        }

}
