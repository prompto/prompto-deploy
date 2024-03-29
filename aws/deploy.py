import json
from subprocess import Popen
import sys
import os
import fnmatch
from urllib2 import urlopen


def install_wget(sudo):
    os.system(sudo + "yum install -y wget")


def locate_jdk():
    jvms_dir = "/usr/java/"
    if not os.path.exists(jvms_dir):
        return None
    jvms = os.listdir(jvms_dir)
    if jvms is None or len(jvms)==0:
        return None
    jdks = fnmatch.filter(jvms, "jdk-17.*")
    if jdks is None or len(jdks)==0:
        return None
    else:
        jdks.sort(reverse=True)
        return jvms_dir + jdks[0]


download_jdk_from_oracle = False

def install_jdk(sudo):
    sys.stdout.write("Installing java SDK...\n")
    jdkdir = locate_jdk()
    if jdkdir is not None:
        os.system('export JAVA_HOME=' + jdkdir)
        sys.stdout.write("Java SDK already installed, skipping\n")
    else:
        os.system(sudo + "wget https://download.oracle.com/java/17/archive/jdk-17.0.2_linux-x64_bin.rpm")
        os.system(sudo + "yum -y localinstall jdk-17.0.2_linux-x64_bin.rpm")
        os.system(sudo + "rm -f jdk-17.0.2_linux-x64_bin.rpm")
        os.system(sudo + "echo 2 | sudo alternatives --config java")
        jdkdir = locate_jdk()
        os.system(sudo + 'sh -c "echo export JAVA_HOME=' + jdkdir + ' >> /etc/environment"')
        sys.stdout.write("Java SDK installed successfully!\n")


def install_mvn(sudo):
    sys.stdout.write("Installing maven...\n")
    if(os.path.exists("/usr/bin/mvn")):
        sys.stdout.write("Maven already installed, skipping\n")
    else:
        os.system(sudo + "wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo")
        os.system(sudo + "yum install -y apache-maven")
        sys.stdout.write("Maven installed successfully!\n")


def install_mongo_tools(sudo):
    sys.stdout.write("Installing mongo shell...\n")
    os.system(sudo + "yum install -y mongodb-org-tools")
    sys.stdout.write("Mongo shell installed successfully!\n")


def install_aws(version, sudo):
    sys.stdout.write("Installing AwsClient...\n")
    os.system("mvn dependency:get -Dartifact=org.prompto:AwsClient:" + version[1:])
    home = "$HOME" if len(sudo) > 0 else "/root"
    prefix = home + "/.m2/repository/org/prompto/AwsClient/"  + version[1:] + "/AwsClient-"  + version[1:]
    # Prompto Server expects aws jars to be located in /AwsClient
    os.system("mvn dependency:copy-dependencies -DincludeScope=runtime -DoutputDirectory=/AwsClient -f " + prefix + ".pom")
    os.system("cp " + prefix + ".jar /AwsClient/AwsClient.jar")
    sys.stdout.write("AwsClient installed successfully!\n")


def install_prompto(version, sudo):
    sys.stdout.write("Downloading Prompto server...\n")
    os.system("mvn dependency:get -Dartifact=org.prompto:Server:" + version[1:])
    sys.stdout.write("Prompto server downloaded successfully!\n")


def install_server(jarName, version, promptoVersion, sudo):
    sys.stdout.write("Installing Prompto " + jarName + "...\n")
    home = "$HOME" if len(sudo) > 0 else "/root"
    prefix = home + "/.m2/repository/org/prompto/Server/"  + promptoVersion[1:] + "/Server-"  + promptoVersion[1:]
    os.system("mvn dependency:copy-dependencies -DincludeScope=runtime -DoutputDirectory=/" + version + " -f " + prefix + ".pom" )
    os.system("mvn dependency:get -Dartifact=org.prompto:" + jarName + ":" + version[1:])
    home = "$HOME" if len(sudo) > 0 else "/root"
    prefix = home + "/.m2/repository/org/prompto/" + jarName + "/"  + version[1:] + "/" + jarName + "-"  + version[1:]
    os.system("mvn dependency:copy-dependencies -DincludeScope=runtime -DoutputDirectory=/" + version + " -f " + prefix + ".pom" )
    os.system("cp " + prefix + ".jar /"  + version + "/")
    sys.stdout.write("Prompto " + jarName + " installed successfully!\n")


def start_server(jarName, version, sudo):
    sys.stdout.write("Starting server...\n")
    cmdLine = sudo + r"java -Xmx256m -javaagent:JarLoader-1.0.1.jar -jar " + jarName + "-" + version[1:] + r".jar -yamlConfigFile /config.yml &"
    sys.stdout.write("Cmd line is: " + cmdLine + "\n")
    os.chdir("/" + version)
    Popen([cmdLine], shell=True)
    Popen(["disown -h"], shell=True)
    sys.stdout.write("Server started successfully!\n")


def install_tools(sudo):
    install_wget(sudo)
    install_mvn(sudo)
    install_jdk(sudo)
    install_mongo_tools(sudo)
    sys.stdout.write("Packages installed successfully!\n")

def install_libs(sudo):
    sys.stdout.write("No library to install!\n")


def install_service(jarName, version, sudo):
    sys.stdout.write("Installing service...\n")
    service = r"""
[Unit]
Description=Prompto Service
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/$version$
ExecStart=java -Xmx256m -javaagent:JarLoader-1.0.1.jar -jar $jarName$-$version$.jar -yamlConfigFile /config.yml
Restart=on-abort

[Install]
WantedBy=multi-user.target
    """
    service = service.replace('$version$', version[1:]).replace('$jarName$', jarName)
    service_file = open("/etc/systemd/system/prompto.service", "wb")
    service_file.write(service)
    service_file.close()
    sys.stdout.write("Service installed successfully!\n")


def fetchLatestPromptoVersion():
    url = "https://api.github.com/repos/prompto/prompto-platform/releases/latest"
    cnx = urlopen(url)
    doc = json.loads(cnx.read())
    return doc['tag_name']


# main script
if __name__ == '__main__':
    jarName = sys.argv[1]
    version = sys.argv[2]
    # special case for scripts
    if version == "latest":
        version = fetchLatestPromptoVersion()
    promptoVersion = sys.argv[3]
    if promptoVersion == "latest":
        promptoVersion = fetchLatestPromptoVersion()
    sudo = ""
    if len(sys.argv) > 4 and sys.argv[4] == "sudo":
        sudo =  r"sudo "
    install_tools(sudo)
    install_libs(sudo)
    install_aws(promptoVersion, sudo)
    install_prompto(promptoVersion, sudo)
    install_server(jarName, version, promptoVersion, sudo)
    install_service(jarName, version, sudo)
    start_server(jarName, version, sudo)
