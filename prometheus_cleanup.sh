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
