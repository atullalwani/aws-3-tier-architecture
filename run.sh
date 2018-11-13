#!/usr/bin/env bash

RUN_COMMAND="${0} ${*}"
export PROJECT_ROOT
PROJECT_ROOT="$(git rev-parse --show-toplevel)"
export TF_VAR_S3_BUCKET_NAME
TF_VAR_S3_BUCKET_NAME="varunthreetierbucket"
RED='\033[0;31m'

test_for_commandline_arguments() {
  if [[ $# -eq 0 ]]; then
    echo -e "${RED}FATAL: no command-line argument"
    usage
    exit 1
  fi
}

assign_commandline_arguments() {
  while [[ $# -gt 0 ]]; do
    case "${1}" in
      -e|--environment)
        ENVIRONMENT=${2}
        export ENVIRONMENT
        shift 2;;
      -e|--confirmation)
        CONFIRMATION=${2}
        export CONFIRMATION
        shift 2;;
      --plan|--show|--apply|--destroy|--run)
        TF_MODE="${1//--/}"
        shift;;
      *)
        echo -e "${RED}FATAL: Unknown command-line argument or environment: ${1}"
        exit 1
    esac
  done
}


terraform_operation() {
  echo "running ${FUNCNAME}"

  local message

  #run_terraform_tests
  pushd ${TF_DIRECTORY}
  terraform init
  case "${TF_MODE}" in
    plan)
      terraform_plan
    ;;
    apply)
      terraform_apply
    ;;
    destroy)
      terraform_destroy
    ;;
  esac
  popd
}

terraform_plan() {
  terraform plan -detailed-exitcode -var-file="${TF_VAR_FILE}"
}

terraform_apply() {
  terraform plan -detailed-exitcode -var-file="${TF_VAR_FILE}"
  TF_RETCODE=${?}
  echo "TF_RETCODE : $TF_RETCODE"
  if [[ ${TF_RETCODE} -eq 2 ]]; then
    echo "Running terraform apply operation"
    if [[ ${CONFIRMATION} == "yes" ]]; then
      terraform apply -auto-approve -var-file="${TF_VAR_FILE}"
      ret_val=$?
      echo "ret_val: ${ret_val}"
      [[ ${ret_val} -ne 0 ]] && \
        echo -e "${RED}WARNING: Terraform plan not applied successfully." \
        exit 1
    else
      terraform apply -var-file="${TF_VAR_FILE}"
      ret_val=$?
      echo "ret_val: ${ret_val}"
      [[ ${ret_val} -ne 0 ]] && \
        echo -e "${RED}WARNING: Terraform plan not applied successfully." \
        exit 1
    fi
  fi
}

terraform_destroy (){
  terraform plan -destroy -var-file="${TF_VAR_FILE}"
  TF_RETCODE=${?}
  echo "TF_RETCODE : $TF_RETCODE"
  if [[ ${CONFIRMATION} == "yes" ]]; then
    echo "TF_RETCODE : $TF_RETCODE"
    terraform destroy -auto-approve -var-file="${TF_VAR_FILE}"
    ret_vala=${?}
    echo "ret_vala: ${ret_vala}"
    [[ ${ret_vala} -ne 0 ]] && \
      echo -e "${RED}WARNING: Terraform plan not applied successfully." \
      exit 1
  else
    terraform destroy -var-file="${TF_VAR_FILE}"
    ret_vala=${?}
    echo "ret_vala: ${ret_vala}"
    [[ ${ret_vala} -ne 0 ]] && \
      echo -e "${RED}WARNING: Terraform plan not applied successfully." \
      exit 1
  fi
}

test_for_commandline_arguments "$@"
assign_commandline_arguments "$@"

echo "ENVIRONMENT: ${ENVIRONMENT}"
export TF_VAR_ENVIRONMENT="${ENVIRONMENT}"
export TF_VAR_DEPLOY_KEY="${PROJECT_ROOT}/configs/${ENVIRONMENT}/${ENVIRONMENT}_deploy_key.pub"


TF_DIRECTORY="${PROJECT_ROOT}/terraform"
TF_VAR_FILE="${PROJECT_ROOT}/configs/${ENVIRONMENT}/${ENVIRONMENT}.tfvars"

aws --profile varun s3 ls "s3://${TF_VAR_S3_BUCKET_NAME}"

exit_val=$?

if [[ ${exit_val} -eq 0 ]]; then
  echo "Bucket already exists with name ${TF_VAR_S3_BUCKET_NAME}."
else
  echo "Bucket does not exist. Creating a bucket with name ${TF_VAR_S3_BUCKET_NAME}."
  aws --profile varun s3api create-bucket --bucket ${TF_VAR_S3_BUCKET_NAME} --region ap-south-1 --create-bucket-configuration LocationConstraint=ap-south-1
fi

aws --profile varun s3 cp "./s3content" s3://${TF_VAR_S3_BUCKET_NAME}/ --recursive

terraform_operation
