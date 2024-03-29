github_version=$(cat github_version.txt)
ftp_version=$(cat ftp_version.txt)
del_version=$(cat delete_version.txt)

if [ $github_version != $ftp_version ]
then
  #Pre-requisitos
  #sudo apt install libseccomp-dev btrfs-progs libbtrfs-dev
  export GOPATH=/var/lib/jenkins/workspace/containerd-cri-release
  #cd /usr/local/go/src/
  echo "Criando pastas"
  mkdir src bin pkg
  cd src
  mkdir github.com
  #cd /usr/local/go/src/github.com/
  #echo "Clonando runc"
  #go get github.com/opencontainers/runc
  #git clone https://github.com/opencontainers/runc.git
  #cd $GOPATH/src/github.com/opencontainers/runc
  #make
  #sudo make install
  echo "Instalando runc"
  go install github.com/opencontainers/runc@latest
  #cd /usr/local/go/src/github.com/
  cd $GOPATH/src/github.com
  #go get github.com/containerd/containerd
  mkdir containerd
  cd containerd
  echo "Release containerd-cri"
  git clone https://github.com/containerd/containerd.git
  cd containerd
  git checkout v$github_version
  #cd $GOPATH/src/github.com/containerd/containerd
  #git checkout f772c10a585ced6be8f86e8c58c2b998412dd963
  #wget https://raw.githubusercontent.com/jr-santos98/containerd/master/script/release/release-cri
  #sudo chmod +x release-cri
  #mv release-cri script/release/
  make
  #make test
  sudo make install
  cd bin
  sudo chmod +x containerd
  cd ..
  make release cri-release cri-cni-release
  #cd $GOPATH/src/github.com/containerd/releases
  cd $GOPATH/src/github.com/containerd/containerd/releases
  ls
  #mv cri-containerd-$github_version.m.linux-ppc64le.tar.gz cri-containerd-$github_version.linux-ppc64le.tar.gz
  #mv cri-containerd-$github_version.m.linux-ppc64le.tar.gz.sha256 cri-containerd-$github_version.linux-ppc64le.tar.gz.sha256
  #mv cri-containerd-cni-$github_version.m.linux-ppc64le.tar.gz cri-containerd-cni-$github_version.linux-ppc64le.tar.gz
  #mv cri-containerd-cni-$github_version.m.linux-ppc64le.tar.gz.sha256 cri-containerd-cni-$github_version.linux-ppc64le.tar.gz.sha256
  if [ $github_version != $ftp_version ]
  then
    lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; cd /ppc64el/containerd-cri/; mkdir containerd-cri-$github_version"
    #lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /ppc64el/containerd-cri/containerd-cri-$github_version/ /var/lib/jenkins/workspace/containerd-cri-release/src/github.com/containerd/releases/cri-containerd-$github_version-linux-ppc64le.tar.gz"
    #lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /ppc64el/containerd-cri/containerd-cri-$github_version/ /var/lib/jenkins/workspace/containerd-cri-release/src/github.com/containerd/releases/cri-containerd-$github_version-linux-ppc64le.tar.gz.sha256"
    lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /ppc64el/containerd-cri/containerd-cri-$github_version/ /var/lib/jenkins/workspace/containerd-cri-release/src/github.com/containerd/containerd/releases/cri-containerd-$github_version-linux-ppc64le.tar.gz"
    lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /ppc64el/containerd-cri/containerd-cri-$github_version/ /var/lib/jenkins/workspace/containerd-cri-release/src/github.com/containerd/containerd/releases/cri-containerd-$github_version-linux-ppc64le.tar.gz.sha256sum"
    #lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /ppc64el/containerd-cri/containerd-cri-$github_version/ /var/lib/jenkins/workspace/containerd-cri-release/src/github.com/containerd/releases/cri-containerd-cni-$github_version-linux-ppc64le.tar.gz"
    #lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /ppc64el/containerd-cri/containerd-cri-$github_version/ /var/lib/jenkins/workspace/containerd-cri-release/src/github.com/containerd/releases/cri-containerd-cni-$github_version-linux-ppc64le.tar.gz.sha256"
    lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /ppc64el/containerd-cri/containerd-cri-$github_version/ /var/lib/jenkins/workspace/containerd-cri-release/src/github.com/containerd/containerd/releases/cri-containerd-cni-$github_version-linux-ppc64le.tar.gz"
    lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /ppc64el/containerd-cri/containerd-cri-$github_version/ /var/lib/jenkins/workspace/containerd-cri-release/src/github.com/containerd/containerd/releases/cri-containerd-cni-$github_version-linux-ppc64le.tar.gz.sha256sum"
  fi
  #cd $GOPATH/src/github.com/containerd/cri/
  #make test-cri
fi
