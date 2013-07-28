function led() {
  signal=${1-on_fade}
  curl 192.168.0.5:8000/led_${signal}
}

