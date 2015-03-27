# HEADER
FROM          abaranov/base
MAINTAINER    abaranov@linux.com

ENV           UPDATED_AT 2015-03-25

ENV           REPO_PUPPETLABS_URL http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm

# Puppetlabs repo
RUN           rpm --quiet -Uvh ${REPO_PUPPETLABS_URL}

# Update yum cache
RUN           yum -y -q makecache && \
              yum -y -q update && \
              yum -y -q clean all

# Install packages
RUN           yum -y -q install \
                puppetdb
              yum -y -q clean all

# Database setup
ADD           database.ini /etc/puppetdb/conf.d/database.ini

# Configure puppetdb
RUN           sed -i -e"s/^# host = .*/host = 0.0.0.0/; \
                        s/^# ssl-host = .*/ssl-host = 0.0.0.0/; \
                        s/^# ssl-port = .*/ssl-port = 8081/"  \
                        /etc/puppetdb/conf.d/jetty.ini

# Expose ports
EXPOSE 8080
EXPOSE 8081

# Default CMD
CMD /usr/sbin/puppetdb ssl-setup && \
    /usr/sbin/puppetdb foreground
