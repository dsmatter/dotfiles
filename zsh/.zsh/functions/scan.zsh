scan() {
  local FN=$1

  if [[ ! ${FN} =~ pdf$ ]]; then
    FN="${FN}.pdf"
  fi

  local SCANOPTS
  SCANOPTS=(--format tiff --resolution 300)
  scanimage ${SCANOPTS} | convert - jpg:- | convert - ${FN}
}

