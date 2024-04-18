<!-- markdownlint-disable MD033 MD041 -->
  <p>
    <a href="https://github.com/spear-ai/pg-signal/actions/workflows/check.yaml">
      <img alt="Checks" src="https://github.com/spear-ai/pg-signal/actions/workflows/check.yaml/badge.svg">
    </a>
  </p>
</div>
<!-- markdownlint-restore MD033 MD041 -->

## Data

Download the [NOAA DCLDE](https://www.soest.hawaii.edu/ore/dclde/dataset) dataset:

```shell
wget https://storage.googleapis.com/noaa-pifsc-bioacoustic/1705_FLAC/1705_20170827_174622_524.flac
sox 1705_20170827_174622_524.flac 1705_20170827_174622_524.dat
tail -n +3 1705_20170827_174622_524.dat | \
  sed -e '1,2d' -e 's/  */,/g' | \
  cut -c2- > 1705_20170827_174622_524.csv
rm 1705_20170827_174622_524.flac
rm 1705_20170827_174622_524.dat
```
