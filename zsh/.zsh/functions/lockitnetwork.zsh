function lnusers {
  URL="$LN_API_BASE_URL/projects/$1/users?token=$LN_API_TOKEN"
  if [[ "$2" != "" ]]; then
    curl -i -d "user=$2" $URL
  fi

  echo $URL
  curl -i "$URL"
}

function allreports {
  curl -i "https://webtools.lockitnetwork.com/api/reports/all?token=$LN_API_TOKEN"
}
