def ipRange(start_ip, end_ip):
  start = list(map(int, start_ip.split(".")))
  end = list(map(int, end_ip.split(".")))
  temp = start
  ip_range = []

  ip_range.append(start_ip)
  while temp != end:
    start[3] += 1
    for i in (3, 2, 1):
      if temp[i] == 256:
        temp[i] = 0
        temp[i-1] += 1
      ip_range.append(".".join(map(str, temp)))

  return ip_range


# sample usage
ip_range = ipRange("10.168.105.143", "10.168.105.174")
for ip in ip_range:
  print(ip)
