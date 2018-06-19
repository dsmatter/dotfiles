function lnusers {
  URL="$LN_API_BASE_URL/projects/$1/users?token=$LN_API_TOKEN"
  if [[ "$2" != "" ]]; then
    curl -i -d "user=$2" $URL
  fi

  echo $URL
  curl -i "$URL"
}

function lnroles {
  URL="$LN_API_BASE_URL/admin/users/$1/roles?token=$LN_API_TOKEN"
  if [[ "$2" != "" ]]; then
    curl -i -X PUT -d "role=$2" $URL
  fi

  echo $URL
  curl -i "$URL"
}

function allreports {
  curl -i "$LN_API_BASE_URL/reports/all?token=$LN_API_TOKEN"
}

function fuzz4prepare {
  PROJECT_ID="$1"
  curl -i -F 'file=@-' "$LN_API_BASE_URL/projects/$PROJECT_ID/import/fuzz4/prepare?token=$LN_API_TOKEN"
}

function fuzz4import {
  PROJECT_ID="$1"
  SCHEDULE="$2"

  echo curl -i -F "'"file=@-"'" "'""$LN_API_BASE_URL/projects/$PROJECT_ID/import/fuzz4?token=$LN_API_TOKEN&schedule=$SCHEDULE&scheduleScenes=true""'"
}
