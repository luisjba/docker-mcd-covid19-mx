# MCD Docker COVID 19 Mexico

This is an ETL tool created on Docker to analize COVID 19 Mexican 
Data Source: [Datos Abiertos Dirección General de Epidemiología](https://www.gob.mx/salud/documentos/datos-abiertos-152127)

This Docker was build from jupyter/scipy-notebook
that belong to the [Jupyter Docker Stacks](https://jupyter-docker-stacks.readthedocs.io/en/latest/index.html) and contains a ready to use Jupyter notebook.
In order to execute our own scripts, this container offer the feature of Startup Hooks 
tha allow us to customize the container environment by adding shell scripts. For this particular Customization, our script was configured to be executed before notebook startup.
Your can inspect our custom script [etl_covidmx.sh](src/etl_covidmx.sh).

## Running the Container

As we used this Jupyter Notebook Container to run our notebook to process and present the results in a better way. To connect our `work` directory to the default Jupyter work directory, we have to set the volume to `/home/jovyan/work` into the option -v as follows.
Be sure to be in the root directoruy of this repo.

```
docker run -p 8888:8888 --name jupyter -v "$PWD/work":/home/jovyan/work luisjba/mcd-covid19-mx
```

Pressing `Ctrl+C` shuts diwn the notebook server but leaves the container intack on the disk and all the work in our connected volume.

To start the stopped jupyter container, you can start it passing the name `jupyter` the same just assigned with the parameter `--name jupyter`, you can modify the name as you canvenience.
```
docker start jupyter
```

To remove the stopped container, just use the same assigned name to stop it.
```
docker rm jupyter
```
