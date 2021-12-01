# Buscaminas - Laboratorio de Programación 1 (FING)

## Introduccion
El BuscaMinas es un videojuego que fue muy popular en los años 90 y principios de los 2000. El objetivo del juego es despejar todas las casillas que no tengan minas de un tablero que representa a un "campo minado". 

![](https://minesweeper.online/img/homepage/expert.png)

El jugador debe presionar sobre cada casilla para descubrirla, si la casilla tiene una mina pierde el juego, si no, la casilla queda descubierta. El jugador gana si logra descubrir todas las casillas que no son minas.

Al descubrirse, algunas casillas tienen un número, que indica cuántas minas hay en las casillas alrededor (por ejemplo, si hay un dos, quiere decir que esa casilla "toca" con dos minas). Si se descubre una mina que no tenga minas alrededor, automáticamente se descubren también esas casillas, repitiéndose ese proceso en caso de que se sigan descubriendo casillas sin minas alrededor.

**Esta tarea consiste en la implementación de una serie de subprogramas necesarios para la implementación del juego BuscaMinas, en el archivo tarea2.pas**.
No está permitido utilizar facilidades de Free Pascal que no forman parte del estándar. Así por ejemplo, no se puede utilizar ninguna de las palabras siguientes: uses, crlscr, gotoxy, crt, readkey, longint, string, break, etcétera.

## Archivos proporcionados
- Archivo BuscaMinas.pas con el programa principal.
- Archivo estructura.pas con las constantes, tipos y subprogramas auxiliares.
- Archivo tarea2.pas con los encabezados de los subprogramas a implementar.
- Carpeta  entradas/,que contiene las entradas al programa principal para realizar los casos de prueba.
- Carpeta  minas/, que contiene distintos juegos (distribuciones de minas).
- Carpeta  salidas/ con las salidas oficiales, o esperadas.
- Carpeta  mios/ con las salidas que se obtienen al ejecutar el programa.
- Carpeta  diffs/ con las resultados de comparar las salidas oficiales y las salidas obtenidas
- Archivo (script) test.sh para compilar, ejecutar y comparar los casos de prueba automáticamente.
- Archivo BuscaminasIF.tcl usado por la interfase gráfica.
- Carpeta  sprites/ con imágenes usadas por la interfase gráfica.

## Ejecución en GUI
Para correr el programa en una GUI se requiere instalar **tcl** y **tk**. Una vez hecho esto se ejecuta con:

``` $ wish BuscaMinasIF.tcl -nombre-archivo- ```

donde *nombre-archivo* es una de las distribuciones de minas ubicadas en la carpeta *minas/*, por ejemplo *m1.inp*

## Ejecucion en CLI
El programa se puede ejecutar de manera interactiva:

``` $ ./BuscaMinas ```

En esta modalidad el programa imprime una línea indicando las dimensiones del tablero, inicia un tablero vacío y lo muestra. Luego queda esperando que el usuario ingrese un comando. Mientras que el juego no termine se repetirá el proceso de mostrar el tablero y esperar un comando.
```
  BUSCAMINAS ANCHO:10 ALTO:10
  ..........
  ..........
  ..........
  ..........
  ..........
  ..........
  ..........
  ..........
  ..........
  ..........
``` 
Los comandos están formados por una letra que lo identifica y una lista de parámetros, posiblemente vacía. Los identificadores de comando son: m, d, q.

### Descripción de los comandos:

**m -nombre-archivo-**
Reinicia el tablero como un tablero vacío (todas las casillas libres y ocultas) y le agrega las minas contenidas en el archivo nombre-archivo. Entre el comando y el parámetro debe haber un solo espacio.

Por ejemplo, si invocamos:

```m minas/m1.inp```

Se carga el tablero con las minas del archivo m1.inp de la carpeta minas.


**d  -fila-  -columna-**
Se descubre una casilla del tablero, determinada por los parámetros fila y columna.

- Si la casilla tiene una bomba, se termina el juego desplegando el mensaje BOOOOOOOOOOM! y mostrando el tablero con todas las minas descubiertas.
- Si la casilla está libre, se realiza el proceso de descubrimiento de casillas tal cual fue descrito anteriormente. Si luego de descubrirse las casillas no queda ninguna casilla oculta que no sea una mina, se termina el juego desplegando el mensaje GANASTE!!!!! y mostrando el tablero en su estado final.

 
**q**
Termina la ejecución del programa y despliega el tablero con todas las casillas desocultadas.

## Verificando con test.sh
``` $ test.sh ``` ejecuta todos los casos de prueba, guarda las salidas en *mios/* y la compara con las de *salidas/*, para archivar las diferencias en *diffs/*. Al mismo tiempo imprime un detalle sobre los casos ejecutados y leaks de memoria.
