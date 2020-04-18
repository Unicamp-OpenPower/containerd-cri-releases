file = open('github_version.txt', 'r')
version = file.readline()
version = version.strip()
file.close()

file = open('github_version.txt', 'w')
file.writelines(version)
file.close()
