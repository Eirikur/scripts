#!/bin/bash

sudo systemctl stop prometheus
sudo systemctl disable prometheus
sudo cp ~/Configuration/prometheus/p1.config /etc/prometheus/prometheus.yml
sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus
sudo systemctl status prometheus
