FROM jupyter/scipy-notebook:584f43f06586

LABEL mantainer="Jose Luis Bracamonte Amavizca <luisjba@gmail.com>"

## Copy the startup hooks
ENV COVID_DATA_URL="http://datosabiertos.salud.gob.mx/gobmx/salud/datos_abiertos/datos_abiertos_covid19.zip" \
    COVID_DATA_HOME=$HOME/work/data \
    COVID_DESTINATION_ZIP_FILE=datos_abiertos_covid19.zip

# Install CSV Kit
USER root

RUN rm /etc/dpkg/dpkg.cfg.d/excludes \
    && apt-get update && apt-get install -y --no-install-recommends \ 
    curl csvkit \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER $NB_UID

# Install from requirements.txt file
COPY --chown=${NB_UID}:${NB_GID} requirements.txt /tmp/

RUN pip install --requirement /tmp/requirements.txt && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

COPY scripts/etl_covidmx.sh /usr/local/bin/start-notebook.d/