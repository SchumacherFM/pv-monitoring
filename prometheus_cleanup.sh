#!/bin/bash
# tomatnine.ch - 08.02.2023
# Voraussetzung: enable option --web.enable-admin-api bei prometheus

# Datum von vor zwei Wochen
#end="`date --iso-8601=seconds -u --date=\"2weeks ago\" | sed -e 's/+00:00/Z/g'`"
end="`date -v-14d +"%s"`"

# DB Grösse anzeigen
#du -sh /var/lib/prometheus/
#IFS="
#"

# Selektiere alle von prometheus selber erstellten Metriken bis Datum von oben
for i in `curl -s http://192.168.0.102:9090/api/v1/label/__name__/values | tr ',' '\n' | tr -d '"' | grep -E '^(prometheus|scrape|process|promhttp|go|net|node|ALERTS|apt)_.*'`
do
  echo "$i => $end\n"
#  curl -X POST -g 'http://192.168.0.102:9090/api/v1/admin/tsdb/delete_series?match[]=counter:mbmd_measurement_l1_energy_exported_total:rate1day'
done
#curl -X POST -g 'http://192.168.0.102:9090/api/v1/admin/tsdb/delete_series?match[]=ALERTS&end='$end
#curl -X POST -g 'http://192.168.0.102:9090/api/v1/admin/tsdb/delete_series?match[]=up&end='$end

# DB aufräumen
#curl -X POST -g 'http://192.168.0.102:9090/api/v1/admin/tsdb/clean_tombstones'

# nochmals messen
#du -sh /var/lib/prometheus/


curl -X POST -g 'http://192.168.0.102:9090/api/v1/admin/tsdb/delete_series?match[]=mbmd_measurement_energy_exported_total%7Bdevice_name%3D%22se17kpv%22%7D&start=2024-05-23T08:53:00Z&end=2024-05-23T09:20:00Z'
curl -X POST -g 'http://192.168.0.102:9090/api/v1/admin/tsdb/delete_series?match[]=mbmd_measurement_energy_exported_total%7Bdevice_name%3D%22se10kpv%22%7D&start=2024-06-12T18:44:00Z&end=2024-06-12T18:53:43Z'

curl 'http://192.168.0.102:9090/api/v1/query_range?query=mbmd_measurement_energy_exported_total%7Bdevice_name%3D%22se17kpv%22%7D&start=2024-05-23T08:53:00Z&end=2024-05-23T09:24:00Z&step=15s'
