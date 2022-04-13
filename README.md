# `dichroism_jupyter`

Conda environments for processing ALS Dichroism data
---

Build and run the `dichroism-jupyter` Docker image
---

This project includes the source files for building a Docker image, as a 
convenience for setting up and running the conda environments with jupyter.

Pre-built docker images are stored in a NERSC registry and can be pulled
on demand.

* The latest stable release is located at:

```
registry.nersc.gov/als/dichroism-jupyter:latest
```

* The latest testing release is located at:

```
registry.nersc.gov/als/dichroism-jupyter:testing
```

### Build from source

From the top-level project directory run the included bash script, 
[`build_image.sh`](https://github.com/als-computing/dichroism_jupyter/tree/main/build_image.sh)
with optional flags:

```bash
# Builds the docker image and enters a temporary container
build_image.sh --run [RUN OPTIONS] [BUILD OPTIONS]

# Builds the docker image, pushes it to a registry, runs docker-compose
build_image.sh --compose [BUILD OPTIONS]

# Additional flags [BUILD OPTIONS] are passed to docker build
build_image.sh --run --no-cache

# Additional flags [RUN OPTIONS] are passed to docker run
build_image.sh --run DEFAULT_ENV_NAME=dbc_fastapi
```

Default values are provided for all environment variables (ENV).
```

Read [here](https://github.com/als-computing/dichroism_jupyter/tree/main/dxr_env/dichroism-jupyter/README.md) 
for further details.

Copyright Notice
---
dichroism_jupyter: Conda environments for processing ALS Dichroism data, 
Copyright (c) 2022, The Regents of the University of California, through 
Lawrence Berkeley National Laboratory (subject to receipt of any required 
approvals from the U.S. Dept. of Energy). All rights reserved.

If you have questions about your rights to use or distribute this software, 
please contact Berkeley Lab's Intellectual Property Office at IPO@lbl.gov.

NOTICE. This Software was developed under funding from the U.S. Department of 
Energy and the U.S. Government consequently retains certain rights. As such, 
the U.S. Government has been granted for itself and others acting on its 
behalf a paid-up, nonexclusive, irrevocable, worldwide license in the 
Software to reproduce, distribute copies to the public, prepare derivative 
works, and perform publicly and display publicly, and to permit other to do 
so. 
