## [PUUBLICADO]

TODO

## [0.1.0]

### Añadido

- Detecta estado de pin en C0 levantando una bandera para el estado logico 0 (5 V en logica inversa).
- Asigna un registro al numero de veces en el que se ha accionado el interruptor (variando entre 0 y 3).
- Alterna las Bombas 1, 2 y 3 dependiendo del valor de registro, encendiendo 2 Bombas y dejando 1 apagada.

## [0.2.0] - 2024-01-30

### Cambios

- Rutina de polling al pin C0 ahora se ejecuta fuera del ciclo infinito.
- Ahora el registro se asigna al numero de veces que una Bomba ha sido encendida.

## [0.3.0] - 2024-01-31

### Eliminado

- Rutina de polling al estado del pin.

### Añadido

- Ahora el estado del pin es adquirido atraves de una rutina en el vector de interrupcion (InterrupOnChange), levantando una bandera en cuanto el pin tenga un cambio de estado.
- Desarrollada una funcion watcher() para detectar el estado del pin apartir de la interrupcion creada por el cambio (inherentemente el cambio no detecta polaridad).
- Desarrollada una funcion para la configuracion de los bits de interrupcion del MCU.

### Cambios

- Configuracion de bits del MCU ahora esta en funciones separadas e independientes al programa principal.

## [0.4.0] - 2024-02-01

### Añadido

- Desarrollada una funcion para la alternancia de las Bombas 1, 2 y 3.
- Banderas para decision de alternancia entre Bombas o Grupos de Trabajo.
- Simultaneo de Bombas cuando el pin C1 este en 0 (5 V en logica inversa).
- El vector de interrupcion de IOC ahora incluye interrupcion por cambio de flanco para el pin C1.

### Eliminado

- Decision de alternancia a partir de registros asignados al historial previo de las Bombas o Grupos de Trabajo.

## [0.5.0] - 2024-02-02

### Añadido

- Rutina de parpadeo para el LED integrado mientras se este tomando una decision de estado de pin.

### Cambios

- Se activo el pull-up interno debil para mejor deteccion de flanco de los pines C0 y C1.

## [0.6.0] - 2024-02-05

### Reparado

- Funcion watcher() ahora mantiene cuenta del contador de pastilla y reinicia a cero antes de un desborde.

### Cambios

- Se trajo de vuelta los registros asignados a las veces que ha detectado flanco positivo la pastilla.

## [0.7.0] - 2024-02-06

### Añadido

- Se añadio una funcion contador que mantiene cuenta del registro asignado al cambio positivo de flanco en los pines C0 y C1 manteniendo el registro entre valores de 0 y 3.
- Desarrolladas funciones encargadas de dejar encendido el grupo de trabajo asignado para el valor de registro actual.

## [0.8.0] - 2024-02-07

## Añadido

- Se desarrollo una maquina de estados finita (FSM) para la toma de decisiones dentro del programa con 4 estados disponibles (S1 - GT1, S2 - GT2, S3 - GT3, S4 - SYM).
- Añadida una funcion de calculo para el siguiente estado basada en mapa de funcion de estados.

## [0.8.1] - 2024-02-09

### Cambios

- Se añadio la purificacion de banderas al inicio del programa.
- Ahora la decision del siguiente estado es tomada dentro de cada caso de la FSM.

### Eliminado

- Rutina de calculo del siguiente estado en la FSM.

### Reparado

- La rutina de decision de flanco para las interrupciones detectadas en el vector de interrupcion de IOC ahora ya no sufren de debouncing.

## [0.8.2] - 2024-02-13

### Añadido

- Desarrollo de estados intermedios donde convergen los estados de trabajo y se decide cual es el siguiente dependidendo de las señales recibidas.
- Banderas de estado negativo para una mejor toma de decisiones dentro de la FSM.

## [0.8.3] - 2024-02-13

### Cambios

- Ahora los pines C0 y C1 trabajan con valores CMOS en vez de valores TTL para denominar cuando el valor logico es 1 o 0.
- Cambios en la FSM para optimizar los estados y prevenir cambios antes de que se deseen.

## [0.8.4] - 2024-02-14

### Añadido

- Añadida interrupcion por desbordamiento de Timer0 para ~1 ms con lo que se simula una señal de reloj artificial.
- Se añadio nuevamente la funcion de parpadeo para la visualizacion del estado del programa.

### Cambios

- Mas mejoras al sistema de la FSM.

## [0.8.5] - 2024-02-16

### Reparado

- Se arreglo bug dentro de la FSM que rotaba entre estados cuando aun no recibia autorizacion.

### Eliminado

- Se elimino la necesidad de la rutina de parpadeo para el cambio entre estados.

## [0.8.6] - 2024-02-20

### Eliminado

- Uso del Timer0

## [0.8.7] - 2024-02-21

### Cambios

- Añadidas señales de confirmacion para cambio de estados.

## [0.8.8] - 2024-02-22

### Cambios

- Alternancia para 1 solo relé (modelo 1 y 1)

### Bugs

- Alternancia no se adhiere al orden 1, 2, 3. Alterna entre distintos relés sin orden aparente.

## [0.8.9] - 2024-03-6

### Cambios

- FSM movida a main.

### Deprecated

- Rutina blink llegando a su EOF.

## [0.9.0] - 2024-03-15

### Añadido

- Default cases para los switches, mejoró el rendimiento y el fixeo de bugs.
- Rutina de Generadora de Codigo Gray, esto permite calcular el siguiente grupo de trabajo a ser llamado dentro de la FSM.

### Eliminado

- La capacidad de decidir el siguiente grupo de trabajo dentro de la FSM.

## [0.9.2] - 2024-03-19

### Reparado

- Bug que permitia a la FSM cambiar de estado antes de darle permiso de paso.
- Manera en que se llama a la funcion Gray Code Machine, ahora se llama desde cada caso en la FSM y regresa un valor que luego se evalua.

## [1.0.0] - 2024-03-22

### Eliminado

- Se revirtio a usar una FSM sin la Generadora de Codigos Gray

## [1.0.2] - 2024-03-26 (Entragado y probado para Carcamo 2)

### Reparado

- La señal clock0 ahora esta dentro de la rutina FSM y la asignacion del siguiente estado fuera de la FSM.
- Se eliminaron los loops de cargar el mismo estado dentro del siguiente estado.

## [1.0.2.1] - 2024-04-04 (En pruebas para entrega a Bypass)

### Modificado

- El grupo de trabajo ahora solo funciona con 1 solo relé a la vez (modo 1 encendido y dos apagados) en orden.
- clock0 se dejo fuera de la FSM y la asignacion del siguiente estado ahora ocurre junto el desborde de tmr0 cada 1 @ 20Mhz.
- Se añadieron de nuevo los loops para cargar el mismo estado dentro de nextstate.

## [1.1.0] - 2024-04-10

#### Añadido

- Soporte para Grupos de Trabajo de 4 relés (2 encendidos, 2 apagados).

## [1.2.0] - 2024-04-20

#### Añadido

- Soporte para Grupos de Trabajo de 5 relés (2 encendidos, 3 apagados alternando con 3 encendidos y 2 apagados).

## [1.3.0] - 2024-05-16

### Añadido

- Soporte para Grupos de Trabajo mixtos (3 niveles, con alternancia equivalente al nivel).
