# Docker, Chef and Apache PoC project

Execute the Dockerfile to copy the centos image, modifies it, install and update apache and starts the httpd service:

Build the docker image. Be sure that you are in the same pwd as is the Dockerfile
```
sudo docker build --rm -t <imageID or imageName>  .
```

Run the container:
```
sudo docker run -d -p 80:80 -p 443:443 <imageID or imageName> 
```

In order for you to observe what has been done on your container you can use the following command:

```
sudo docker run -i -t <imageID or imageName> /bin/bash 
```

Note that in order for us to configure apache, we are going to use the Apache2 cookbook set from the official Chef supermarket: https://supermarket.chef.io/cookbooks/apache2

# Technology and implementation

In this PoC project, the following different techniques have been used:
 - Borrowing apache2 cookbooks and templates from the official chef supermarket and using them to configure the default http virtualhost
 - Creating custom file template and using it to enable and configure SSL 
 - Class: Chef::Util::FileEdit class to modify the file's content (http://www.rubydoc.info/gems/chef/Chef/Util/FileEdit).
 - Other techniques like executing commands directly, appending to files from the console output and other chef operators 
