# elk-ec2-terraform-aws
Provision infrastructure for the ELK stack on AWS via Terraform.
Create VPC, SG, EC2 and assign DNS via Route 53 private hosting zone. 

### Ansible for Windows with Docker 
```shell
docker run --rm -it -v C:\Users\user\Ansible:/ansible  -v C:\Users\user\.ssh:/root/.ssh willhallonline/ansible:2.9-centos-7 /bin/sh
```
### SSL Cert with acme.sh
```shell
acme.sh --issue --dns dns_gd -d es1-sb.dfh.ai -d es2-sb.dfh.ai -d es3-sb.dfh.ai -d es4-sb.dfh.ai -d es5-sb.dfh.ai -d kibana-sb.dfh.ai  --force

[Tue Feb  2 07:42:03 PM CST 2021] Your cert is in  /home/mnm/.acme.sh/es1-sb.dfh.ai/es1-sb.dfh.ai.cer 
[Tue Feb  2 07:42:03 PM CST 2021] Your cert key is in  /home/mnm/.acme.sh/es1-sb.dfh.ai/es1-sb.dfh.ai.key 
[Tue Feb  2 07:42:03 PM CST 2021] The intermediate CA cert is in  /home/mnm/.acme.sh/es1-sb.dfh.ai/ca.cer 
[Tue Feb  2 07:42:03 PM CST 2021] And the full chain certs is there:  /home/mnm/.acme.sh/es1-sb.dfh.ai/fullchain.cer 
[mnm@localhost AWS]$ 
```



### Generate the p12 file 
```shell
$ openssl pkcs12 -export  -inkey es1-sb.dfh.ai.key  -in es1-sb.dfh.ai.cer -certfile fullchain.cer -out es-sb.dfh.ai.p12 
Enter Export Password:
Verifying - Enter Export Password:

$ openssl pkcs12 -export  -inkey es1-sb.dfh.ai.key  -in es1-sb.dfh.ai.cer -certfile fullchain.cer -out es-sb.dfh.ai.p12 env:somevar
[mnm@localhost es1-sb.dfh.ai]$ 
```

            
# Ansible SSH Hostfile for Inventory

```shell
aws ec2 describe-instances \
--filters Name=tag:Name,Values=POC*  "Name=instance-state-name, Values=running"  \
--query 'Reservations[*].Instances[*].{ PublicIpAddress:PublicIpAddress,Name:Tags[?Key==`Name`]|[0].Value }'  \
--region us-east-1 \
--output text \
--profile hgs |awk '{print "Host hgs-"tolower($1)"\nHostName "$2}'
```            

