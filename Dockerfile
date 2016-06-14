# DOCKER-VERSION 0.5.3

FROM centos:6 

MAINTAINER Mihail Mihaylov "mihail.georgiev.mihaylov@gmail.com"

RUN yum -y update

RUN yum -y install curl build-essential libxml2-dev libxslt-dev git

RUN yum -y install libevent-devel

RUN yum -y install gcc gcc-c++ 

RUN yum -y groupinstall "Development Tools"

RUN curl -L https://www.opscode.com/chef/install.sh | bash

RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc

RUN /opt/chef/embedded/bin/gem install berkshelf

ADD solo.rb /chef/solo.rb
ADD solo.json /chef/solo.json
ADD ./cookbooks /chef/cookbooks

RUN chef-solo -c /chef/solo.rb

EXPOSE 80 443

ADD start-httpd.sh /start-httpd.sh
RUN chmod -v +x /start-httpd.sh

CMD ["/start-httpd.sh"]
