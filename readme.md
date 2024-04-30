# Photovoltaic Monitoring Setup WIP

### Hardware

- 66x420W Trina Solar Vertex FB
- SolarEdge SE10K-RWS (28 panels)
- SolarEdge SE17K (28+10 panels)
- SolarEdge Meter
- AlphaInnotec LWCV 82R1/3 Heat pump
- ABB Terra 22KW wall box with display and TCP Modbus build-in

### Software

- evcc
- custom volkszaehler/mbmd with Prometheus export
- influxdb
- grafana
- luxws-exporter

TODO: secrets management in yaml files.

#### WIP How to query Prometheus for monthly data in Grafana

https://sysrant.com/posts/monthly-reports-with-grafana-and-prometheus/

