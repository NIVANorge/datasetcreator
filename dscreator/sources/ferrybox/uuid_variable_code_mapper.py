MAPPER = {
    "FA":
    # these are taken from nivaprod
    {
        "Temperature": "720b78cb-3e82-4c4d-9b63-7d1ae1b7afc1",  # degC, FA/INLET/SBE38/TEMPERATURE/RAW
        "Salinity": "314cd400-14a7-489a-ab97-bce6b11ad068",  # PSU, SBE45, FA/FERRYBOX/SBE45/SALINITY/RAW
        # Oxygen metadata on prod are buggy. FA/INLET/OPTODE/OXYGEN_SATURATION/RAW is displayed as the new path for
        # FA/ferrybox/INLET/OPTODE/OXYGEN/SATURATION However data are attached to the old path
        "Oxygen": [("2019-12-31T23:59:59", "e03fba93-1fed-49c2-ac5a-601dc2475915"), # FA/ferrybox/INLET/OPTODE/OXYGEN/SATURATION
                   ("2200-12-31T23:59:59", "f831af38-d376-406d-8388-be6f3312f578")], # %, FA/FERRYBOX/OPTODE/OXYGEN_SATURATION/RAW
        # for 2020-2022 FA/Ferrybox/OPTODE/OXYGEN_SATURATION/RAW
        "track": "4d9ff393-25a3-47b8-aaf1-8fbbccfec3c3",  # FA/gpstrack
    },
    # # these are taken from nivatest
    # {
    #     "Temperature": "720b78cb-3e82-4c4d-9b63-7d1ae1b7afc1",  # degC, FA/INLET/SBE38/TEMPERATURE/RAW
    #     "Turbidity": "8891c0e9-0cd1-4367-973e-b491c1a7626e",  # FTU, FA/FERRYBOX/C3/TURBIDITY/ADJUSTED
    #     "Chlorophyll": "e39f2868-4c4d-4dff-a468-e3f917f6576e",  # mg/m^3, FA/FERRYBOX/C3/CHLA_FLUORESCENCE/ADJUSTED
    #     "cDOM": "94b4d859-3525-49bd-bf1e-2612f85b8f45",  # "mg/m^3", FA/FERRYBOX/C3/CDOM_FLUORESCENCE/ADJUSTED
    #     "Salinity": "322d4e72-8eef-4d77-bc7b-43351e38f1a8",  # PSU, SBE45, FA/FERRYBOX/SBE45/SALINITY/RAW
    #     "Oxygen": "698cec13-9d0f-46a3-a28e-819fee0c3cc0",  # RBR, %, FA/FERRYBOX/RBR/OXYGEN_SATURATION/RAW
    #     "track": "4d9ff393-25a3-47b8-aaf1-8fbbccfec3c3",  # FA/gpstrack
    # },
    #
    "TF": {},
    "NB": {},
}
