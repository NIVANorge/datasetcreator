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
    },
    "TF": {},
    "NB": {
        "temperature": "7d4003e3-51e3-45e7-aab0-56f46b508b0b",  # degc, NB/INLET/SBE38/TEMPERATURE/RAW
        "salinity": "441771b6-ca91-4cc7-a837-f1504c04e5a2",  # psu, sbe45, NB/FERRYBOX/SBE45/SALINITY/RAW
        "oxygen_sat": "bc22b061-6e75-4139-b52c-ce12610683df",  # aanderaa, %,  NB/FERRYBOX/OPTODE/OXYGEN_SATURATION/RAW
        "track": "72708b78-f8b6-4969-af70-426021c7d155",  # NB/gpstrack
        "chlorophyll": "2204490f-884a-4158-86f1-30ab0c509f65",  # NB/FERRYBOX/C3/CHLA_FLUORESCENCE/SENSOR_ADJUSTED
        "turbidity": "c6e48009-6ad9-4b3b-b3fc-17202189c2e0",  # NB/FERRYBOX/C3/TURBIDITY/SENSOR_ADJUSTED
        "fdom": "e6455d65-7294-47a7-88f6-5295338a542b",  # NB/FERRYBOX/C3/CDOM_FLUORESCENCE/SENSOR_ADJUSTED
    },
}
