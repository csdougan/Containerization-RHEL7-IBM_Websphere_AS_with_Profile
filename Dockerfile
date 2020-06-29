# Requires web server running, serving install files up via HTTP
# Used 'hello-world-nginx' container with the /website_files volume remapped to the project directory for
# this container.   'hello-world-nginx' was built from kinematic/http.

FROM cdougan/wasdev
MAINTAINER Craig Dougan "Craig.Dougan@gmail.com"

ADD startWAS.sh /tmp/startWAS.sh
RUN cd /tmp && \
    mkdir -p /usr/local/bin && \
    mv /tmp/startWAS.sh /usr/local/bin && \
    chmod u+x /usr/local/bin/startWAS.sh
    
# Let's expose at least HTTP and Dmgr(Admin) ports for this profile
EXPOSE 9080 9060 22 8877

# Make sure WAS will be started any time we start docker container with /bin/bash support.

ENTRYPOINT ["/usr/local/bin/startWAS.sh"]
CMD ["DEV", "1", "DCKR"]

