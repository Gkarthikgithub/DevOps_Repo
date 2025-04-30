1.Install the dependencies using the below command.
sudo apt install php-cli unzip curl php-mbstring php-xml composer  -y
create the project
composer create-project --prefer-dist yiisoft/yii2-app-basic <project name>
create dockerfile and docker compose file for the project.
create a random key and add it in web.php file, we can use the below command to generate a random key.
head -c 32 /dev/urandom | base64
Launch an ec2 instance with following configuration.
OS: ububtu
storage : 20GB
inbound rules: 22 80 8080 443
install following packages in the server  i.e git, docker, php, ansible, nginx, curl, unzip 
create default.conf in the sites-available and link it between sites-available and sites-enabled.
create a workflow file in the github in .github/workflows folder so that it will run on every push to the main branch.
create a github secrets for the workflow, add docker hub username and password for pushing image to docker hub.
add ec2 server ip , port and username and private key in the github repository secrets.
create a key pair using the ssh-keygen command.
add public key in the authorized keys in the server and private key in the github secrets for authentication between github actionas and ec2 instance.

