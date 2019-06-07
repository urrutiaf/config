# config
Mis archivos de configuración

## Como instalar todo
Primero tenemos que instalar oh-my-bash, que es un montón de configuraciones de bash que hacen que bash sea más cool.

Para esto ejecutamos el siguiente comando en la terminal:

```
sh -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"
```

Y una vez hecho esto, instalamos fzf que nos va a permitir hacer búsquedas de archivos (con CTRL+t) y comandos anteriores (con CTRL+r):

```
sudo apt-get install git
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
yes | ~/.fzf/install
```

