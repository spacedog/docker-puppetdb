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

# Expose ports
EXPOSE 8080
EXPOSE 8081

# Enrtypoint
ENTRYPOINT ["/usr/sbin/puppetdb"]

# Default CMD
CMD ["foreground"]
