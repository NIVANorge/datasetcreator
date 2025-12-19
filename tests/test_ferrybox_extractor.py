from datetime import datetime

import pytest

from dscreator.sources import ferrybox


@pytest.fixture
def ferrybox_extractor(db_engine) -> ferrybox.extractor.TrajectoryExtractor:
    traj_extractor = ferrybox.extractor.TrajectoryExtractor(
        db_engine,
        variable_codes=["temperature", "salinity", "oxygen_sat"],
        variable_uuid_map=ferrybox.uuid_variable_code_mapper.MAPPER["FA_19"],
        qc_flags=[1],
    )
    return traj_extractor


@pytest.fixture
def spectra_extractor(db_engine) -> ferrybox.extractor.TrajectoryExtractor:
    spectra_extractor = ferrybox.extractor.SpectraExtractor(
        db_engine,
        variable_codes=["rrs_344", "rrs_452"],
        variable_uuid_map=ferrybox.uuid_variable_code_mapper.MAPPER["FA_19"],
        qc_flags=[1],
        with_qc=False,
    )
    return spectra_extractor



@pytest.mark.docker
def test_trajectory_extractor_timestamps(ferrybox_extractor: ferrybox.extractor.TrajectoryExtractor):
    assert ferrybox_extractor.first_timestamp() == datetime(2019, 12, 31, 23, 59, 53)
    assert ferrybox_extractor.last_timestamp() == datetime(2020, 1, 2, 23, 59, 49)


@pytest.mark.docker
def test_trajectory_values(ferrybox_extractor: ferrybox.extractor.TrajectoryExtractor):
    data_dict = ferrybox_extractor.fetch_slice(datetime(2020, 1, 1, 14, 20), datetime(2020, 1, 1, 14, 22))
    assert len(data_dict) == 9
    assert "temperature" in data_dict
    assert "oxygen_sat" in data_dict
    assert data_dict["temperature"] == [5.425, 5.519]
    assert data_dict["salinity"] == [26.248, 26.309]
    assert data_dict["time"] == [datetime(2020, 1, 1, 14, 20, 38), datetime(2020, 1, 1, 14, 21, 39)]


@pytest.mark.docker
def test_spectra_extractor_timestamps(spectra_extractor: ferrybox.extractor.SpectraExtractor):
    assert spectra_extractor.first_timestamp() == datetime(2025, 2, 5, 8, 35, 41)
    assert spectra_extractor.last_timestamp() == datetime(2025, 2, 5, 8, 59, 52)


@pytest.mark.docker
def test_spectra_values(spectra_extractor: ferrybox.extractor.SpectraExtractor):
    data_dict = spectra_extractor.fetch_slice(datetime(2025, 2, 5), datetime(2025, 2, 6))
    assert len(data_dict) == 5
    assert "rrs_344" in data_dict
    assert "rrs_452" in data_dict
    assert data_dict["rrs_344"] == [0.0006604349498171411, 0.0006579092427698614, None, None]
    assert data_dict["rrs_452"] == [None, 1.5, 2, 5]
    assert data_dict["time"] == [datetime(2025, 2, 5, 8, min) for min in range(49, 53)]