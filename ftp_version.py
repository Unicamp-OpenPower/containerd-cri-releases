import requests
import re

# find and save the current Github release
html = str(
    requests.get('https://github.com/containerd/containerd/releases/latest')
    .content)
index = html.find('Release ')
github_version = html[index + 19:index + 25]
file = open('github_version.txt', 'w')
file.writelines(github_version)
file.close()

# find and save the current Bazel version on FTP server
html = str(
    requests.get(
        'https://oplab9.parqtec.unicamp.br/pub/ppc64el/containerd-cri/latest/'
    ).content)
index = html.rfind('containerd-cri-')
ftp_version = html[index + 15:index + 21]
file = open('ftp_version.txt', 'w')
file.writelines(ftp_version)
file.close()

# find and save the oldest Bazel version on FTP server
index = html.rfind('containerd-cri-')
delete = html[index + 15:index + 21]
file = open('delete_version.txt', 'w')
file.writelines(delete)
file.close()
