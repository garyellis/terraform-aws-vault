
function read_ca_certificate(){
  curl -k -s ${VAULT_ADDR}/v1/$1/ca/pem|openssl x509 -noout -text
}

function list_aws_auth_method_roles(){
  vault list /auth/$1/roles
}

function read_aws_auth_method_role(){
  auth_method_path=$1
  role_name=$2
  vault read /auth/$auth_method_path/role/$role_name
}

eval "$@"
