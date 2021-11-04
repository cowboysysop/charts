# Cowboy Sysop Charts

[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Release Charts](../../workflows/Release%20Charts/badge.svg)](../../actions?query=workflow%3A%22Release+Charts%22)
[![Renovate](https://img.shields.io/badge/Renovate-enabled-green.svg?logo=renovatebot)](https://renovatebot.com/)
[![Downloads](https://img.shields.io/github/downloads/cowboysysop/charts/total?color=green&label=Downloads)](https://somsubhra.github.io/github-release-stats/?username=cowboysysop&repository=charts)

## Charts

| Name                                                      | Description                                                                                                                  |
|-----------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------|
| [kroki](charts/kroki)                                     | Creates diagrams from textual descriptions                                                                                   |
| [kubebox](charts/kubebox)                                 | Terminal and Web console for Kubernetes                                                                                      |
| [kubeview](charts/kubeview)                               | Kubernetes cluster visualiser and graphical explorer                                                                         |
| [lighthouse-ci](charts/lighthouse-ci)                     | Enables running a server to display Lighthouse CI results                                                                    |
| [mongo-express](charts/mongo-express)                     | Web-based MongoDB admin interface, written with Node.js and express                                                          |
| [mpi-operator](charts/mpi-operator)                       | Makes it easy to run allreduce-style distributed training on Kubernetes                                                      |
| [notebook-controller](charts/notebook-controller)         | A Kubernetes controller that spawns a notebook for a user on Kubernetes                                                      |
| [quickchart](charts/quickchart)                           | Chart image and QR code web API                                                                                              |
| [training-operator](charts/training-operator)             | Makes it easy to run distributed or non-distributed TensorFlow/PyTorch/MXNet/XGBoost jobs on Kubernetes                      |
| [vertical-pod-autoscaler](charts/vertical-pod-autoscaler) | Set of components that automatically adjust the amount of CPU and memory requested by pods running in the Kubernetes Cluster |
| [whoami](charts/whoami)                                   | Tiny Go webserver that prints os information and HTTP request to output                                                      |

## Quality

All these charts are tested with [ct](https://github.com/helm/chart-testing) on multiple Kubernetes versions, from v1.16 to v1.22, with the help of [kind](https://kind.sigs.k8s.io/).

## Contributing

As this is a personal project, as I want to keep some consistency between these charts and as I don't have enough time to write down the best practices I use, I'm not accepting any pull requests.

However, I'll be happy to add some new features to these charts, so don't hesitate to open issues to submit your needs.
