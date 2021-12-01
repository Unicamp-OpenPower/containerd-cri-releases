#!/usr/bin/env bash
github_version=$(cat github_version.txt)
ftp_version=$(cat ftp_version.txt)
LOCALPATH=/var/lib/jenkins/workspace/containerd-cri-release
BINPATH=$LOCALPATH/src/github.com/containerd/cri/_output

if [ $github_version != $ftp_version ]
then
  cd $LOCALPATH
  git clone https://$USERNAME:$TOKEN@github.com/Unicamp-OpenPower/repository-scrips.git
  cd repository-scrips/
  chmod +x empacotar-cri-deb.sh
  chmod +x empacotar-cri-rpm.sh
  chmod +x empacotar-cri-cni-rpm.sh
  sudo mv empacotar-cri-deb.sh $BINPATH
  sudo mv empacotar-cri-rpm.sh $BINPATH
  sudo mv empacotar-cri-cni-rpm.sh $BINPATH
  cd $BINPATH
  sudo ./empacotar-cri-deb.sh containerd-cri cri-containerd-$github_version-linux-ppc64le.tar.gz $github_version
  sudo ./empacotar-cri-deb.sh containerd-cri-cni cri-containerd-cni-$github_version-linux-ppc64le.tar.gz $github_version
  sudo ./empacotar-cri-rpm.sh cri-containerd-$github_version-linux-ppc64le.tar.gz $github_version
  sudo ./empacotar-cri-cni-rpm.sh cri-containerd-cni-$github_version-linux-ppc64le.tar.gz $github_version
  if [ $github_version > $ftp_version ]
  then
    lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /repository/debian/ppc64el/containerd/ $BINPATH/containerd-cri-$github_version-ppc64le.deb"
    lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /repository/debian/ppc64el/containerd/ $BINPATH/containerd-cri-cni-$github_version-ppc64le.deb"
    sudo lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /repository/rpm/ppc64le/containerd/ ~/rpmbuild/RPMS/ppc64le/containerd-cri-$github_version-1.ppc64le.rpm"
    sudo lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /repository/rpm/ppc64le/containerd/ ~/rpmbuild/RPMS/ppc64le/containerd-cri-cni-$github_version-1.ppc64le.rpm"
  fi
fi
