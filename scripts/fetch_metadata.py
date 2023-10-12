import os
import requests

current_path = os.path.join(os.path.dirname(os.path.realpath(__file__)), "..", "catalog", "metadata")
tds_url = "https://thredds.niva.no/thredds/iso/datasets"
cat_base = "catalog=file:/usr/local/tomcat/content/thredds/subcatalogs"
datasets = [
    ("msource-inlet", "d2675936-8ebf-4fc5-988c-4a5198b2df57", "loggers"),
    ("msource-outlet", "4b123377-e0a6-4c7e-b466-2f8a3199bc86", "loggers")
]

for ds_name, uuid, cat_name in datasets:
    ds_url = f"{tds_url}/{ds_name}.nc?{cat_base}/{cat_name}.xml&dataset={uuid}"
    res = requests.get(ds_url)
    with open(os.path.join(current_path, f"{ds_name}.xml"), "w") as f:
        f.write(res.text)