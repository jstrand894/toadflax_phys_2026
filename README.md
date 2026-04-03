# toadflax_phys_2026

Greenhouse experiment examining the physiological stress responses of yellow toadflax (*Linaria vulgaris*) and dalmatian toadflax (*Linaria dalmatica*) to infestation by their respective host-specific biocontrol weevils: *Mecinus janthinus* on *L. vulgaris* and *Mecinus janthiniformis* on *L. dalmatica*.

## Overview

This project tests whether each *Linaria* species mounts a measurable physiological stress response to infestation by its associated biocontrol weevil. Response variables include gas exchange parameters and leaf/canopy spectral reflectance, providing an integrated picture of photosynthetic performance and stress-related pigment changes across infested and control plants.

## Repository Structure

```
toadflax_phys_2026/
├── data_in/
│   ├── 6400_data/        # Raw LI-COR 6400XT gas exchange files
│   └── ASD_data/         # Raw FieldSpec spectroradiometer reflectance files
└── toadflax_phys_2026.Rproj
```

> Additional directories (processed data, scripts, figures) will be added as the project develops.

## Data

**`data_in/6400_data/`** -- Raw output files from the LI-COR 6400XT portable photosynthesis system. Variables include net photosynthetic rate (A), stomatal conductance (gs), transpiration (E), and intercellular CO2 concentration (Ci).

**`data_in/ASD_data/`** -- Raw spectral reflectance files from the ASD FieldSpec spectroradiometer. Used to derive vegetation indices associated with pigment content and stress (e.g., red-edge position, NDVI, PRI).

## Species and Treatments

| Host Plant | Biocontrol Agent | Damage Type |
|---|---|---|
| *Linaria vulgaris* (yellow toadflax) | *Mecinus janthinus* | Stem boring |
| *Linaria dalmatica* (dalmatian toadflax) | *Mecinus janthiniformis* | Stem boring |

Each species was tested with infested and uninfested (control) treatments under greenhouse conditions.

## Dependencies

Analysis is conducted in R. Package dependencies will be documented in a `renv.lock` file or listed here as the analysis pipeline is finalized.

## Contact

Jackson Strand
Department of Land Resources and Environmental Science
Montana State University, Bozeman, MT