# Cowboy Sysop Charts

[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org/)
[![Semantic Versioning](https://img.shields.io/badge/Semantic%20Versioning-2.0.0-yellow.svg?logo=semver)](https://semver.org/)

[![Renovate](https://img.shields.io/badge/Renovate-enabled-brightgreen.svg?logo=renovatebot)](https://renovatebot.com/)
[![Release Charts](../../workflows/Release%20Charts/badge.svg)](../../actions?query=workflow%3A%22Release+Charts%22)
[![Downloads](https://img.shields.io/github/downloads/cowboysysop/charts/total?label=Downloads)](https://somsubhra.github.io/github-release-stats/?username=cowboysysop&repository=charts)

## Charts

| Name                                                      | Description                                                                                                                  |
|-----------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------|
| [cert-manager-common](charts/cert-manager-common)         | Collection of Kubernetes objects common to all Cert-Manager instances                                                        |
| [dolibarr](charts/dolibarr)                               | A modern software package to manage your company or foundation's activity                                                    |
| [flowise](charts/flowise)                                 | Drag & drop UI to build your customized LLM flow                                                                             |
| [grafana-mcp](charts/grafana-mcp)                         | Model Context Protocol server for Grafana                                                                                    |
| [kroki](charts/kroki)                                     | Creates diagrams from textual descriptions                                                                                   |
| [kubebox](charts/kubebox)                                 | Terminal and Web console for Kubernetes                                                                                      |
| [kubeview](charts/kubeview)                               | Kubernetes cluster visualiser and graphical explorer                                                                         |
| [lighthouse-ci](charts/lighthouse-ci)                     | Enables running a server to display Lighthouse CI results                                                                    |
| [local-ai](charts/local-ai)                               | A drop-in replacement REST API compatible with OpenAI API specifications for local inferencing                               |
| [mongo-express](charts/mongo-express)                     | Web-based MongoDB admin interface, written with Node.js and express                                                          |
| [ollama](charts/ollama)                                   | Get up and running with large language models, locally                                                                       |
| [qdrant](charts/qdrant)                                   | Vector similarity search engine and vector database                                                                          |
| [quickchart](charts/quickchart)                           | Chart image and QR code web API                                                                                              |
| [redis-extra](charts/redis-extra)                         | Collection of extra Kubernetes objects for a Redis instance                                                                  |
| [vertical-pod-autoscaler](charts/vertical-pod-autoscaler) | Set of components that automatically adjust the amount of CPU and memory requested by pods running in the Kubernetes Cluster |
| [whoami](charts/whoami)                                   | Tiny Go webserver that prints os information and HTTP request to output                                                      |

## Quality

All these charts are tested with [ct](https://github.com/helm/chart-testing) on multiple Kubernetes versions, from v1.24 to v1.27, with the help of [kind](https://kind.sigs.k8s.io/).

## Contributing

As this is a personal project, as I want to keep some consistency between these charts and as I don't have enough time to write down the best practices I use, I'm not accepting any pull requests.

However, I'll be happy to add some new features to these charts, so don't hesitate to open issues to submit your needs.

## Repository Settings

Add a secret named `RENOVATE_TOKEN` containing a [Personal Access Token](https://github.com/settings/tokens) with `repo` and `workflow` scopes to make [Renovate GitHub Action](https://github.com/renovatebot/github-action) work.
