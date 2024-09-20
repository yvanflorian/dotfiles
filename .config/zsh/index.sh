#!/usr/bin/bash

export ZSH_WORK_DIR="$HOME/.config/zsh"


#
# Utility to always call for functions that 
# require argument. This util will check that the number of 
# required arguments was provided
flenv_check_number_required_args() {
  local expected=$1
  shift
  if [[ $# -lt $expected ]]; then
      echo "Error: Expected at least $expected argument(s), but got $#" >&2
      return 1
  fi
}

## JSON.stringify()
json_marshal(){
  flenv_check_number_required_args 1 "$@" || return 1
  printf "$1" | jq -c @json
}

## Godoc
gd() {
  flenv_check_number_required_args 1 "$@" || return 1
  go doc "$1" | bat --language go
}

# Used only here to check environment flag
flenv_check_flag() {
  local env="$1"
  ##check validity of flags
  if [[ $env == "prod" || $env == "uat" || $env == "dev" || $env == "local" ]]; then
    :
  else
    gum log --level error "Invalid flag. Must be prod uat local dev"
    return 1
  fi
}

# Loading Environment Variables
# from the encrypted file
#
flenv_load_envs(){
  flenv_check_number_required_args 1 "$@" || return 1
  local env="$1"
  gum log --level debug "env is: $env"
  flenv_check_flag "$env" || return 1

  local ENVS_FILE="$ZSH_WORK_DIR/envs.yml"
  ansible-vault decrypt "$ENVS_FILE" > /dev/null 2>&1

  ## Export as environmnent variables
  export FLENV_ENVIRONMENT="$env"
  FLENV_DB_USERNAME=$(<"$ENVS_FILE" yq -r ".$env.databases.spifapex_username")
  FLENV_DB_PASSWORD=$(<"$ENVS_FILE" yq -r ".$env.databases.spifapex_password")
  FLENV_GOTMS_BASEURL=$(<"$ENVS_FILE" yq -r ".$env.gotms.base_url")
  FLENV_GOTMS_APIKEY=$(<"$ENVS_FILE" yq -r ".$env.gotms.api_key")
  FLENV_GOTMS_USERNAME=$(<"$ENVS_FILE" yq -r ".$env.gotms.username")
  FLENV_GOTMS_PASSWORD=$(<"$ENVS_FILE" yq -r ".$env.gotms.password")
  FLENV_TMS_BASEURL=$(<"$ENVS_FILE" yq -r ".$env.tms.base_url")
  FLENV_TMS_RESTPATH=$(<"$ENVS_FILE" yq -r ".$env.tms.rest_path")
  FLENV_TMS_CW_APIUSER=$(<"$ENVS_FILE" yq -r ".$env.tms.cw_user")
  FLENV_TMS_CW_APIPASSWORD=$(<"$ENVS_FILE" yq -r ".$env.tms.cw_password")
  NEST_PREFIX=$(<"$ENVS_FILE" yq -r ".$env.tms.nest_prefix")
  FLENV_TMS_NEST_BASEURL="$FLENV_TMS_BASEURL$NEST_PREFIX"
  FLENV_RABBITMQ_BASEURL=$(<"$ENVS_FILE" yq -r ".$env.rabbitmq.base_url")
  FLENV_RABBITMQ_AUTHHEADER=$(<"$ENVS_FILE" yq -r ".$env.rabbitmq.auth_header")

  export FLENV_DB_USERNAME
  export FLENV_DB_PASSWORD
  export FLENV_GOTMS_BASEURL
  export FLENV_GOTMS_APIKEY
  export FLENV_GOTMS_USERNAME
  export FLENV_GOTMS_PASSWORD
  export FLENV_TMS_BASEURL
  export FLENV_TMS_RESTPATH
  export FLENV_TMS_CW_APIUSER
  export FLENV_TMS_CW_APIPASSWORD
  export FLENV_TMS_NEST_BASEURL
  export FLENV_RABBITMQ_BASEURL
  export FLENV_RABBITMQ_AUTHHEADER

  ansible-vault encrypt "$ENVS_FILE" > /dev/null 2>&1
  gum log --level debug "FLENV Environments Set Successfully! (prefix: FLENV_*)"
}

##
# Utility Function 
# You give it a number and it substracts for you 
# a number of days from today
flenv_subtract_days() {
    local input_date
    input_date=$(date -u +"%Y-%m-%dT%H:%M:%S.%3N")
    local days_to_subtract="$1"

    # Extract the date part (before 'T') and the time part (after 'T')
    local date_part="${input_date%%T*}"
    local time_part="${input_date##*T}"

    # Subtract the days
    local new_date
    new_date=$(date -u -d "$date_part - $days_to_subtract days" +"%Y-%m-%d")

    # Combine the new date with the original time part
    local new_datetime="${new_date}T${time_part}"

    echo "$new_datetime"
}

#
# Utility Function To run a simple curl Get command 
# and give you an output or Fail altogether if there's 
# and error
flenv_curl_get(){
  flenv_check_number_required_args 1 "$@" || return 1
  if output=$(curl -fsSL "$1" 2>&1) && printf  '%s\n' "$output" 
  then
    :
  else
    { gum log --level error "Curl Failed: $output" >&2; exit 1; }
  fi
}


#
# Load other custom/private scripts
#
source "$ZSH_WORK_DIR/private/work/index.sh"
