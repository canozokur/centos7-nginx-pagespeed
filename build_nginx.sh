#!/bin/bash
NGINX_VERSION=$1
PAGESPEED_VERSION="${2}-beta"
PSOL_VERSION=${2}

set -e
set -x

print_usage() {
  echo ""
  echo "Usage: $0 nginx_version pagespeed_version"
  echo "Ex: $0 1.10.1-1.el7 1.11.33.4"
  exit 1
}

if [ -z "${1}" ];
then
  echo "ngx vers bos olamaz. son vers icin http://nginx.org/packages/centos/7/SRPMS/"
  print_usage
  exit 1
fi

if [ -z "${2}" ];
then
  echo "pagespeed versiyonu bos olamaz. son versiyon icin; https://developers.google.com/speed/pagespeed/module/release_notes"
  print_usage
  exit 1
fi

rm -rf rpmbuild
rpm -Uvh http://nginx.org/packages/centos/7/SRPMS/nginx-${NGINX_VERSION}.ngx.src.rpm

wget https://github.com/pagespeed/ngx_pagespeed/archive/release-${PAGESPEED_VERSION}.zip
unzip release-${PAGESPEED_VERSION}.zip
rm release-${PAGESPEED_VERSION}.zip -f

cd ngx_pagespeed-release-${PAGESPEED_VERSION}/
wget https://dl.google.com/dl/page-speed/psol/${PSOL_VERSION}.tar.gz
tar zxvf ${PSOL_VERSION}.tar.gz
rm ${PSOL_VERSION}.tar.gz -f

cd ..
tar zcvf ngx_pagespeed-release-${PAGESPEED_VERSION}.tar.gz ngx_pagespeed-release-${PAGESPEED_VERSION}/
rm -rf ngx_pagespeed-release-${PAGESPEED_VERSION}/
cd ~

cp -f spec.patch.template spec.patch
sed -i "s/#{PAGESPEED_VERSION}/${PAGESPEED_VERSION}/g" spec.patch
patch -b rpmbuild/SPECS/nginx.spec spec.patch

mv ngx_pagespeed-release-${PAGESPEED_VERSION}.tar.gz ~/rpmbuild/SOURCES/.
rpmbuild -ba ~/rpmbuild/SPECS/nginx.spec
