"""Generate data for PostgreSQL database."""  # noqa: INP001

import math
from datetime import UTC, datetime, timedelta
from pathlib import Path
from urllib.request import urlretrieve

import pandas as pd
import sox


def generate() -> None:
    """Generate PostgreSQL data from the NOAA DCLDE dataset."""
    file_directory = (Path(__file__) / "../files").resolve()

    initial_datetime = datetime(
        year=2017,
        month=8,
        day=27,
        hour=17,
        minute=46,
        second=22,
        microsecond=524000,
        tzinfo=UTC,
    )

    # Fetch first five partitions (5m)
    for partition in range(5):
        current_datetime = initial_datetime + timedelta(seconds=(60 * partition))
        datetime_key = f"{current_datetime.strftime('%Y%m%d_%H%M%S')}_{math.floor(current_datetime.microsecond / 1000)}"
        audio_url = f"https://storage.googleapis.com/noaa-pifsc-bioacoustic/1705_FLAC/1705_{datetime_key}.flac"
        audio_file_path = file_directory / f"temp_{datetime_key}.flac"

        # Download audio file from Google Cloud Storage
        urlretrieve(audio_url, audio_file_path)  # noqa: S310

        # Split audio file into three chunks (20s)
        for chunk in range(3):
            dat_file_path = file_directory / f"{audio_file_path.stem}_{chunk}.dat"
            csv_file_path = file_directory / f"audio_sample_{partition}_{chunk}_channel_1.csv"

            # Transcode audio file to slimmed down `.dat` file
            transformer = sox.Transformer()
            transformer.rate(50_000)  # Downsample from 500kHz to 50Khz
            transformer.remix(remix_dictionary={1: [1]})  # Drop channels 2–6  # noqa: RUF003
            transformer.trim(20 * chunk, 20 + 20 * chunk)  # Slice off 20s chunk
            transformer.build(audio_file_path, dat_file_path)

            dataframe = pd.read_csv(
                dat_file_path,
                header=None,
                names=["time_offset", "amplitude"],
                sep=r"\s+",
                skiprows=2,
            )
            dataframe["datetime"] = dataframe.apply(
                lambda row: current_datetime  # noqa: B023
                + timedelta(seconds=(20 * chunk))  # noqa: B023
                + timedelta(microseconds=int(1_000_000 * row["time_offset"])),
                axis=1,
            )
            dataframe["signal_channel_id"] = "3834c3a4-dd65-4c22-97b3-e874fa53164a"
            dataframe = dataframe.drop(["time_offset"], axis=1)
            dataframe.to_csv(csv_file_path, index=False)


if __name__ == "__main__":
    generate()
