
$similar_machine_number=2

$install_nginx = <<END
sudo yum install -y epel-release
sudo yum install -y nginx
service nginx start
END

$install_apache = <<END
sudo yum -y update
sudo yum install -y httpd
END



Vagrant.configure("2") do |config|
    
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory=256
    vb.cpus=1
    vb.check_guest_additions=false 
    config.vm.box_check_update=false
    config.vm.box = "centos/7"
    config.vm.provision "shell", inline: $install_apache 
    #config.vm.provision "shell", inline: $install_nginx
      
  end

#config.vm.provision "shell", inline: $install_nginx

  (1..$similar_machine_number).each do |i|
    config.vm.define  "lnu1810devops_#{i}" do |lnu1810devops|  
      lnu1810devops.vm.network "private_network", ip: "1.168.1.10#{i}"
      lnu1810devops.vm.hostname = "lnu1810devops#{i}"
      

      lnu1810devops.vm.provision "shell", inline: <<-SHELL
        sudo su
        adduser lnudevopsuser#{i}
        echo -e "1\n1" | passwd  lnudevopsuser#{i}
      
        usermod -aG wheel lnudevopsuser#{i}
        sudo su - lnudevopsuser#{i}
        systemctl start httpd
        #mv /etc/httpd/conf.d/welcome.conf /etc/httpd/conf.d/welcome.conf_backup
        #systemctl restart httpd
        #echo "<h1>Epta!</h1>" > /var/www/html/index.html
      SHELL
  
      lnu1810devops.vm.provision :shell do |shell|
        shell.args = "#{i}"
        shell.path = "setWebs.sh"
      end
    end
  end
  


  #creating balanser
  config.vm.define  "lnu1810devops_3" do |lnu1810devops| 
    
    lnu1810devops.vm.network "private_network", ip: "1.168.1.103"
    lnu1810devops.vm.hostname = "lnu1810devops3"
    #lnu1810devops.vm.provision "shell", inline: $install_nginx
    
    #lnu1810devops.vm.provision "shell", path: "setBalancer.sh"# set lnu1810devops_3

  end


end
