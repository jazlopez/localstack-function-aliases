function _localstack_s3_ls__help_() {
    printf "%s\n%s\n" "Usage:" " localstack_s3_ls"
    _contactme_
}

function _localstack_s3_ls_() {
  printf "%s\n"  "Localstack, listing S3 buckets... please wait..."
  printf "%s\n"  "..............................................."
  aws --endpoint-url="${LOCALSTACKURL}" s3 ls

  if [ $? != 0 ]; then
    _localstack_s3_ls_help_ 
  fi
}
function _localstack_s3_mb_help_() {
    printf "%s\n   %s\n" "Usage" "localstack_s3_mb :bucketname (bucketname must follow s3 naming standards)"
    _contactme_
}
function _localstack_s3_mb_() {

  local VALIDATION_ERROR=""

  echo "Localstack, creating S3 bucket... please wait..."
  echo "..............................................."

  if [ -z $1 ]; then
    printf "%s\n" "[ERROR] Argument bucket name is required"
    _localstack_s3_mb_help_
    return 1
  fi
  aws --endpoint-url="${LOCALSTACKURL}" s3 mb "s3://$1"

 if [ $? != 0 ]; then 
    _localstack_s3_mb_help_
  fi
}


alias localstack_s3_ls=_localstack_s3_ls_
alias localstack_s3_mb=_localstack_s3_mb_
