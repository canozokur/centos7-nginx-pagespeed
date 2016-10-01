# centos7-nginx-pagespeed
Simple script to build nginx with pagespeed module. **Tested on CentOS7 only.**

**!!!!BEWARE!!!!**

This script comes with no warranty, if it deletes your files or burns your house, don't come looking for me.
It just works for me and it makes a few assumptions, **always check the script first before running it.**

For example this script always deletes the `rpmbuild` directory before it starts running. So if you have a couple of build projects lying around in your build user homedir, **be careful.**

**!!!!!!!!!!!!!!**


- You'll need the following packages; `gcc-c++ pcre-devel zlib-devel make unzip wget openssl-devel libxml2-devel libxslt-devel gd-devel perl-ExtUtils-Embed GeoIP-devel gperftools-devel rpm-build` - install them first.
- Create an unprivileged build user
- Switch (`su`) to that user
- Go to your build user's home directory
- Clone this repo
- Run the build_nginx.sh script
- Check `${BUILD_USER_HOME}/rpmbuild/RPMS/x86_64` directory for your newly built RPMs
- ??
- Profit
