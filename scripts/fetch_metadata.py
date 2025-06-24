# %%
import os
import requests
from lxml import etree

# %%

cat_path = os.path.join(os.path.dirname(os.path.realpath(__file__)), "..", "catalog", "metadata")
target_path = os.environ.get("METADATA_PATH", cat_path)
catalog_base = "https://thredds.niva.no/thredds/catalog/subcatalogs"
iso_url = "https://thredds.niva.no/thredds/iso"
cat_file = "catalog=file:/usr/local/tomcat/content/thredds/subcatalogs"

# %%
datasets = []
for cat in ["ferryboxes", "loggers", "samples"]:
    cat_doc = etree.fromstring(requests.get(f"{catalog_base}/{cat}.xml").content)
    for el in cat_doc:
        if el.tag.endswith("dataset") and el[0].text in ["trajectory", "trajectory-download", "timeseries", "timeseries-download"]:
            datasets.append((el.get("urlPath"), el.get("ID"), cat))

# %%
for ds_name, uuid, cat_name in datasets:
    ds_url = f"{iso_url}/{ds_name}?{cat_file}/{cat_name}.xml&dataset={uuid}"
    res = requests.get(ds_url)
    with open(os.path.join(target_path, f"{ds_name.split('/')[-1]}.xml"), "w") as f:
        f.write(res.text)

# %%
