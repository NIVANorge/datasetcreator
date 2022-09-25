from dataexport.thredds_utils import dds_to_index

def test_dds_to_index():
    text = 'Dataset {\n    Int32 time[time = 192];\n} datasets/sios.nc;\n'
    assert dds_to_index(text) == 192