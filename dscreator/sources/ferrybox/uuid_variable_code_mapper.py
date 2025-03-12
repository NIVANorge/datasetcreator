MAPPER = {
    "FA_18":
    # norsoop pre 2019 uuids
    {
        "temperature": "720b78cb-3e82-4c4d-9b63-7d1ae1b7afc1",  # degC, FA/INLET/SBE38/TEMPERATURE/RAW
        "salinity": "314cd400-14a7-489a-ab97-bce6b11ad068",  # PSU, SBE45, FA/FERRYBOX/SBE45/SALINITY/RAW
        "oxygen_sat": "e03fba93-1fed-49c2-ac5a-601dc2475915",  # aanderaa, %, FA/ferrybox/INLET/OPTODE/OXYGEN/SATURATION
        "track": "4d9ff393-25a3-47b8-aaf1-8fbbccfec3c3",  # FA/gpstrack
    },
    "FA_19":
    # norsoop post 2019 uuids
    {
        "temperature": "720b78cb-3e82-4c4d-9b63-7d1ae1b7afc1",  # degc, fa/inlet/sbe38/temperature/raw
        "salinity": "314cd400-14a7-489a-ab97-bce6b11ad068",  # psu, sbe45, fa/ferrybox/sbe45/salinity/raw
        "oxygen_sat": "f831af38-d376-406d-8388-be6f3312f578",  # aanderaa, %,  FA/FERRYBOX/OPTODE/OXYGEN_SATURATION/RAW
        "track": "4d9ff393-25a3-47b8-aaf1-8fbbccfec3c3",  # fa/gpstrack
        "chlorophyll": "ea782920-a5e1-415e-930b-b7c12e3cf366",  # FA/FERRYBOX/C3/CHLA_FLUORESCENCE/SENSOR_ADJUSTED
        "turbidity": "de22c594-b313-4c13-ae84-1810eb5841e2",  # FA/FERRYBOX/C3/TURBIDITY/SENSOR_ADJUSTED
        "fdom": "a02eea6b-042d-4209-8307-c88230639b86",  # FA/FERRYBOX/C3/CDOM_FLUORESCENCE/SENSOR_ADJUSTED
        "rrs_344": "f8a2e40c-1225-4b51-8a07-eb2051a5d736_344", # FA/RAMSES/DERIVED/RRS/CALIBRATED 344
        "rrs_452": "f8a2e40c-1225-4b51-8a07-eb2051a5d736_452", # FA/RAMSES/DERIVED/RRS/CALIBRATED 344
        "rrs_671": "f8a2e40c-1225-4b51-8a07-eb2051a5d736_671" # FA/RAMSES/DERIVED/RRS/CALIBRATED 344
    },
    "TF": {},
    "NB": {},
}
