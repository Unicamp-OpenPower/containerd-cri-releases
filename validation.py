file = open('github_version.txt', 'r')
version = file.readline()
version = version.strip()
file.close()

file = open('github_version.txt', 'w')
file.writelines(version)
file.close()

file = open('ftp_version.txt', 'r')
version = file.readline()
version = version.strip()
version = version.rstrip('/')
file.close()

file = open('ftp_version.txt', 'w')
file.writelines(version)
file.close()
