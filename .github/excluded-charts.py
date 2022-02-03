import argparse
import os

import semantic_version
import yaml

parser = argparse.ArgumentParser()
parser.add_argument("--kube-version", required=True)
args = parser.parse_args()

kube_version = args.kube_version.removeprefix("v")
version = semantic_version.Version(kube_version)

excluded_charts = []

charts = os.listdir("charts")

for chart in charts:
    with open(f"charts/{chart}/Chart.yaml", "r") as stream:
        chart_yaml = yaml.safe_load(stream)
        chart_annotations = chart_yaml.get("annotations")

        if chart_annotations is not None:
            chart_kube_version = chart_annotations.get("kubeVersion")

            if chart_kube_version is not None:
                spec = semantic_version.NpmSpec(chart_kube_version)

                if version not in spec:
                    excluded_charts.append(chart)

separator = ","
print(separator.join(excluded_charts))
