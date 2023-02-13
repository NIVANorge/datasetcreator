import netCDF4 as nc
import os
# fn = '/Users/zofiarudjord/NIVAcode/datasetcreator/catalog/datasets/norsoop/rt_ferrybox_FA/2022-12-12T160100Z_rt_ferrybox_fa.nc'
fn = os.getcwd()+'/example_trajectory.nc'
ds = nc.Dataset(fn)

print(ds.__dict__)

