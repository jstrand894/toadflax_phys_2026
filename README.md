# toadflax_phys_2026

Greenhouse experiments examining the physiological stress responses of *Linaria* spp. to infestation by stem-boring and gall-forming biocontrol weevils. Two sequential experiments were conducted: a single-agent experiment comparing host-specific weevil responses across two toadflax species, and a dual-agent experiment testing additive and interactive effects of two weevils on yellow toadflax.

## Overview

**Single-agent experiment:** *Linaria vulgaris* (yellow toadflax) infested with *Mecinus janthinus* and *Linaria dalmatica* (dalmatian toadflax) infested with *Mecinus janthiniformis* were compared against uninfested controls. This experiment tests whether each host species mounts a detectable physiological stress response to its associated stem-boring weevil.

**Dual-agent experiment:** *Linaria vulgaris* plants were assigned to one of four treatments -- control, *M. janthinus* only, *Rhinusa pilosa* only, or *M. janthinus* + *R. pilosa* -- to assess whether co-infestation produces additive, synergistic, or antagonistic effects on plant physiology.

Response variables include gas exchange parameters and leaf/canopy spectral reflectance.

## Repository Structure

```
toadflax_phys_2026/
├── data_in/
│   ├── 6400_data/        # Raw LI-COR 6400XT gas exchange files (both experiments)
│   └── ASD_data/         # Raw FieldSpec spectroradiometer reflectance files (both experiments)
└── toadflax_phys_2026.Rproj
```

> Additional directories (processed data, scripts, figures) will be added as the project develops.

## Experimental Design

Replicates were started on a staggered weekly schedule: weeks 1-4 initiated single-agent reps, weeks 5-8 initiated dual-agent reps. Each rep was measured at 1, 2, 4, 7, and 10 weeks post-infestation. All raw data files from both experiments are stored together within their respective instrument directories.

### Single-agent experiment

| Host Plant | Biocontrol Agent | Damage Type |
|---|---|---|
| *Linaria vulgaris* (yellow toadflax) | *Mecinus janthinus* | Stem boring |
| *Linaria dalmatica* (dalmatian toadflax) | *Mecinus janthiniformis* | Stem boring |

### Dual-agent experiment (*Linaria vulgaris* only)

| Treatment | Weevils Present |
|---|---|
| Control | None |
| *M. janthinus* | Stem-boring weevil only |
| *R. pilosa* | Gall-forming weevil only |
| *M. janthinus* + *R. pilosa* | Both weevils |

## Data

**`data_in/6400_data/`** -- Raw output files from the LI-COR 6400XT portable photosynthesis system. Variables include net photosynthetic rate (A), stomatal conductance (gs), transpiration (E), and intercellular CO2 concentration (Ci).

**`data_in/ASD_data/`** -- Raw spectral reflectance files from the ASD FieldSpec spectroradiometer. Used to derive vegetation indices associated with pigment content and stress (e.g., red-edge position, NDVI, PRI).

## Dependencies

Analysis is conducted in R. Package dependencies will be documented in a `renv.lock` file or listed here as the analysis pipeline is finalized.

## Contact

Jackson Strand  
Department of Land Resources and Environmental Science  
Montana State University, Bozeman, MT