#!/bin/bash
# create directory to store metrics information
mkdir /opt/monitor_metrics
# netdata_apps_bandwidth_tcp_recv_calls_persec_average
touch /opt/monitor_metrics/netdata_apps_bandwidth_tcp_recv_calls_persec_average-$(date +%Y-%m-%d).csv
chmod a+rw /opt/monitor_metrics/netdata_apps_bandwidth_tcp_recv_calls_persec_average-$(date +%Y-%m-%d).csv
su postgres -c "psql -U postgres -d timescaledb_db -c \"COPY
(SELECT
    time, value, val(instance_id) as instance
FROM
    netdata_apps_bandwidth_tcp_recv_calls_persec_average
WHERE
    time > TIMESTAMP 'yesterday') TO '/opt/monitor_metrics/netdata_apps_bandwidth_tcp_recv_calls_persec_average-$(date +%Y-%m-%d).csv' with csv;\""

# netdata_apps_bandwidth_tcp_retransmit_calls_persec_average
touch /opt/monitor_metrics/netdata_apps_bandwidth_tcp_retransmit_calls_persec_average-$(date +%Y-%m-%d).csv
chmod a+rw /opt/monitor_metrics/netdata_apps_bandwidth_tcp_retransmit_calls_persec_average-$(date +%Y-%m-%d).csv
su postgres -c "psql -U postgres -d timescaledb_db -c \"COPY
(SELECT
    time, value, val(instance_id) as instance
FROM
    netdata_apps_bandwidth_tcp_retransmit_calls_persec_average
WHERE
    time > TIMESTAMP 'yesterday') TO '/opt/monitor_metrics/netdata_apps_bandwidth_tcp_retransmit_calls_persec_average-$(date +%Y-%m-%d).csv' with csv;\""

# netdata_apps_bandwidth_tcp_send_calls_persec_average
touch /opt/monitor_metrics/netdata_apps_bandwidth_tcp_send_calls_persec_average-$(date +%Y-%m-%d).csv
chmod a+rw /opt/monitor_metrics/netdata_apps_bandwidth_tcp_send_calls_persec_average-$(date +%Y-%m-%d).csv
su postgres -c "psql -U postgres -d timescaledb_db -c \"COPY
(SELECT
    time, value, val(instance_id) as instance
FROM
    netdata_apps_bandwidth_tcp_send_calls_persec_average
WHERE
    time > TIMESTAMP 'yesterday') TO '/opt/monitor_metrics/netdata_apps_bandwidth_tcp_send_calls_persec_average-$(date +%Y-%m-%d).csv' with csv;\""

# netdata_apps_bandwidth_udp_recv_calls_persec_average
touch /opt/monitor_metrics/netdata_apps_bandwidth_udp_recv_calls_persec_average-$(date +%Y-%m-%d).csv
chmod a+rw /opt/monitor_metrics/netdata_apps_bandwidth_udp_recv_calls_persec_average-$(date +%Y-%m-%d).csv
su postgres -c "psql -U postgres -d timescaledb_db -c \"COPY
(SELECT
    time, value, val(instance_id) as instance
FROM
    netdata_apps_bandwidth_udp_recv_calls_persec_average
WHERE
    time > TIMESTAMP 'yesterday') TO '/opt/monitor_metrics/netdata_apps_bandwidth_udp_recv_calls_persec_average-$(date +%Y-%m-%d).csv' with csv;\""

# netdata_apps_bandwidth_udp_send_calls_persec_average
touch /opt/monitor_metrics/netdata_apps_bandwidth_udp_send_calls_persec_average-$(date +%Y-%m-%d).csv
chmod a+rw /opt/monitor_metrics/netdata_apps_bandwidth_udp_send_calls_persec_average-$(date +%Y-%m-%d).csv
su postgres -c "psql -U postgres -d timescaledb_db -c \"COPY
(SELECT
    time, value, val(instance_id) as instance
FROM
    netdata_apps_bandwidth_udp_send_calls_persec_average
WHERE
    time > TIMESTAMP 'yesterday') TO '/opt/monitor_metrics/netdata_apps_bandwidth_udp_send_calls_persec_average-$(date +%Y-%m-%d).csv' with csv;\""

# netdata_apps_total_bandwidth_recv_kilobits_persec_average
touch /opt/monitor_metrics/netdata_apps_total_bandwidth_recv_kilobits_persec_average-$(date +%Y-%m-%d).csv
chmod a+rw /opt/monitor_metrics/netdata_apps_total_bandwidth_recv_kilobits_persec_average-$(date +%Y-%m-%d).csv
su postgres -c "psql -U postgres -d timescaledb_db -c \"COPY
(SELECT
    time, value, val(instance_id) as instance
FROM
    netdata_apps_total_bandwidth_recv_kilobits_persec_average
WHERE
    time > TIMESTAMP 'yesterday') TO '/opt/monitor_metrics/netdata_apps_total_bandwidth_recv_kilobits_persec_average-$(date +%Y-%m-%d).csv' with csv;\""

# netdata_apps_total_bandwidth_sent_kilobits_persec_average
touch /opt/monitor_metrics/netdata_apps_total_bandwidth_sent_kilobits_persec_average-$(date +%Y-%m-%d).csv
chmod a+rw /opt/monitor_metrics/netdata_apps_total_bandwidth_sent_kilobits_persec_average-$(date +%Y-%m-%d).csv
su postgres -c "psql -U postgres -d timescaledb_db -c \"COPY
(SELECT
    time, value, val(instance_id) as instance
FROM
    netdata_apps_total_bandwidth_sent_kilobits_persec_average
WHERE
    time > TIMESTAMP 'yesterday') TO '/opt/monitor_metrics/netdata_apps_total_bandwidth_sent_kilobits_persec_average-$(date +%Y-%m-%d).csv' with csv;\""

# netdata_ip_ecnpkts_packets_persec_average
touch /opt/monitor_metrics/netdata_ip_ecnpkts_packets_persec_average-$(date +%Y-%m-%d).csv
chmod a+rw /opt/monitor_metrics/netdata_ip_ecnpkts_packets_persec_average-$(date +%Y-%m-%d).csv
su postgres -c "psql -U postgres -d timescaledb_db -c \"COPY
(SELECT
    time, value, val(instance_id) as instance
FROM
    netdata_ip_ecnpkts_packets_persec_average
WHERE
    time > TIMESTAMP 'yesterday') TO '/opt/monitor_metrics/netdata_ip_ecnpkts_packets_persec_average-$(date +%Y-%m-%d).csv' with csv;\""

# netdata_ip_tcp_retransmit_calls_persec_average
touch /opt/monitor_metrics/netdata_ip_tcp_retransmit_calls_persec_average-$(date +%Y-%m-%d).csv
chmod a+rw /opt/monitor_metrics/netdata_ip_tcp_retransmit_calls_persec_average-$(date +%Y-%m-%d).csv
su postgres -c "psql -U postgres -d timescaledb_db -c \"COPY
(SELECT
    time, value, val(instance_id) as instance
FROM
    netdata_ip_tcp_retransmit_calls_persec_average
WHERE
    time > TIMESTAMP 'yesterday') TO '/opt/monitor_metrics/netdata_ip_tcp_retransmit_calls_persec_average-$(date +%Y-%m-%d).csv' with csv;\""

# netdata_ip_total_tcp_bandwidth_kilobits_persec_average
touch /opt/monitor_metrics/netdata_ip_total_tcp_bandwidth_kilobits_persec_average-$(date +%Y-%m-%d).csv
chmod a+rw /opt/monitor_metrics/netdata_ip_total_tcp_bandwidth_kilobits_persec_average-$(date +%Y-%m-%d).csv
su postgres -c "psql -U postgres -d timescaledb_db -c \"COPY
(SELECT
    time, value, val(instance_id) as instance
FROM
    netdata_ip_total_tcp_bandwidth_kilobits_persec_average
WHERE
    time > TIMESTAMP 'yesterday') TO '/opt/monitor_metrics/netdata_ip_total_tcp_bandwidth_kilobits_persec_average-$(date +%Y-%m-%d).csv' with csv;\""

# netdata_ip_total_udp_bandwidth_kilobits_persec_average
touch /opt/monitor_metrics/netdata_ip_total_udp_bandwidth_kilobits_persec_average-$(date +%Y-%m-%d).csv
chmod a+rw /opt/monitor_metrics/netdata_ip_total_udp_bandwidth_kilobits_persec_average-$(date +%Y-%m-%d).csv
su postgres -c "psql -U postgres -d timescaledb_db -c \"COPY
(SELECT
    time, value, val(instance_id) as instance
FROM
    netdata_ip_total_udp_bandwidth_kilobits_persec_average
WHERE
    time > TIMESTAMP 'yesterday') TO '/opt/monitor_metrics/netdata_ip_total_udp_bandwidth_kilobits_persec_average-$(date +%Y-%m-%d).csv' with csv;\""

# netdata_ipv4_icmp_packets_persec_average
touch /opt/monitor_metrics/netdata_ipv4_icmp_packets_persec_average-$(date +%Y-%m-%d).csv
chmod a+rw /opt/monitor_metrics/netdata_ipv4_icmp_packets_persec_average-$(date +%Y-%m-%d).csv
su postgres -c "psql -U postgres -d timescaledb_db -c \"COPY
(SELECT
    time, value, val(instance_id) as instance
FROM
    netdata_ipv4_icmp_packets_persec_average
WHERE
    time > TIMESTAMP 'yesterday') TO '/opt/monitor_metrics/netdata_ipv4_icmp_packets_persec_average-$(date +%Y-%m-%d).csv' with csv;\""

# netdata_ipv4_packets_packets_persec_average
touch /opt/monitor_metrics/netdata_ipv4_packets_packets_persec_average-$(date +%Y-%m-%d).csv
chmod a+rw /opt/monitor_metrics/netdata_ipv4_packets_packets_persec_average-$(date +%Y-%m-%d).csv
su postgres -c "psql -U postgres -d timescaledb_db -c \"COPY
(SELECT
    time, value, val(instance_id) as instance
FROM
    netdata_ipv4_packets_packets_persec_average
WHERE
    time > TIMESTAMP 'yesterday') TO '/opt/monitor_metrics/netdata_ipv4_packets_packets_persec_average-$(date +%Y-%m-%d).csv' with csv;\""

# netdata_ipv4_tcperrors_packets_persec_average
touch /opt/monitor_metrics/netdata_ipv4_tcperrors_packets_persec_average-$(date +%Y-%m-%d).csv
chmod a+rw /opt/monitor_metrics/netdata_ipv4_tcperrors_packets_persec_average-$(date +%Y-%m-%d).csv
su postgres -c "psql -U postgres -d timescaledb_db -c \"COPY
(SELECT
    time, value, val(instance_id) as instance
FROM
    netdata_ipv4_tcperrors_packets_persec_average
WHERE
    time > TIMESTAMP 'yesterday') TO '/opt/monitor_metrics/netdata_ipv4_tcperrors_packets_persec_average-$(date +%Y-%m-%d).csv' with csv;\""

# node_network_device_id
touch /opt/monitor_metrics/node_network_device_id-$(date +%Y-%m-%d).csv
chmod a+rw /opt/monitor_metrics/node_network_device_id-$(date +%Y-%m-%d).csv
su postgres -c "psql -U postgres -d timescaledb_db -c \"COPY
(SELECT
    time, value, val(instance_id) as instance
FROM
    node_network_device_id
WHERE
    time > TIMESTAMP 'yesterday') TO '/opt/monitor_metrics/node_network_device_id-$(date +%Y-%m-%d).csv' with csv;\""

# node_network_protocol_type
touch /opt/monitor_metrics/node_network_protocol_type-$(date +%Y-%m-%d).csv
chmod a+rw /opt/monitor_metrics/node_network_protocol_type-$(date +%Y-%m-%d).csv
su postgres -c "psql -U postgres -d timescaledb_db -c \"COPY
(SELECT
    time, value, val(instance_id) as instance
FROM
    node_network_protocol_type
WHERE
    time > TIMESTAMP 'yesterday') TO '/opt/monitor_metrics/node_network_protocol_type-$(date +%Y-%m-%d).csv' with csv;\""

# node_network_transmit_packets_total
touch /opt/monitor_metrics/node_network_transmit_packets_total-$(date +%Y-%m-%d).csv
chmod a+rw /opt/monitor_metrics/node_network_transmit_packets_total-$(date +%Y-%m-%d).csv
su postgres -c "psql -U postgres -d timescaledb_db -c \"COPY
(SELECT
    time, value, val(instance_id) as instance
FROM
    node_network_transmit_packets_total
WHERE
    time > TIMESTAMP 'yesterday') TO '/opt/monitor_metrics/node_network_transmit_packets_total-$(date +%Y-%m-%d).csv' with csv;\""

# node_network_transmit_queue_length
touch /opt/monitor_metrics/node_network_transmit_queue_length-$(date +%Y-%m-%d).csv
chmod a+rw /opt/monitor_metrics/node_network_transmit_queue_length-$(date +%Y-%m-%d).csv
su postgres -c "psql -U postgres -d timescaledb_db -c \"COPY
(SELECT
    time, value, val(instance_id) as instance
FROM
    node_network_transmit_queue_length
WHERE
    time > TIMESTAMP 'yesterday') TO '/opt/monitor_metrics/node_network_transmit_queue_length-$(date +%Y-%m-%d).csv' with csv;\""

# node_network_receive_packets_total
touch /opt/monitor_metrics/node_network_receive_packets_total-$(date +%Y-%m-%d).csv
chmod a+rw /opt/monitor_metrics/node_network_receive_packets_total-$(date +%Y-%m-%d).csv
su postgres -c "psql -U postgres -d timescaledb_db -c \"COPY
(SELECT
    time, value, val(instance_id) as instance
FROM
    node_network_receive_packets_total
WHERE
    time > TIMESTAMP 'yesterday') TO '/opt/monitor_metrics/node_network_receive_packets_total-$(date +%Y-%m-%d).csv' with csv;\""

# node_network_info
touch /opt/monitor_metrics/node_network_info-$(date +%Y-%m-%d).csv
chmod a+rw /opt/monitor_metrics/node_network_info-$(date +%Y-%m-%d).csv
su postgres -c "psql -U postgres -d timescaledb_db -c \"COPY
(SELECT
    time, value, val(instance_id) as instance
FROM
    node_network_info
WHERE
    time > TIMESTAMP 'yesterday') TO '/opt/monitor_metrics/node_network_info-$(date +%Y-%m-%d).csv' with csv;\""


