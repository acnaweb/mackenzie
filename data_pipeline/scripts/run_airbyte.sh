#!/bin/bash

# clone Airbyte from GitHub
git clone --depth=1 https://github.com/airbytehq/airbyte.git

# switch into Airbyte directory
cd airbyte

# start Airbyte
chmod +x run-ab-platform.sh
bash run-ab-platform.sh