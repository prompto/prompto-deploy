from deploy import *

# main script
if __name__ == '__main__':
    version = sys.argv[1]
    if version == "latest":
        version = fetchLatestPromptoVersion()
    sudo = ""
    install_tools(sudo)
    install_libs(sudo)
    install_aws(version, sudo)
    install_prompto(version, sudo)
