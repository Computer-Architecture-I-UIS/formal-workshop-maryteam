 Mary Zuleika Jimenez Diaz 2150952-Camilo Santamaria 2145548 - Alejandro Navarro / MARYTEAM 
================
VERIFICACION PWM
================

DIAGRAMA DE BLOQUES
-------------------

DESCRIPCION
-----------

Primero se modificó el archivo scala y verilog, para adicionar una salida más al archivo del PWM usado en el primer taller, esta salida corresponde al contador antes era una variable interna del código. La  variable contador es importante en las comparaciones que se realiza en la verificación.

Al momento que se realizo el archivo de SimbyYosis “.sby” se indicó que se emplea la verificación con los tres solucionadores vistos en clases los cuales son Z3 ,boolector  y Yices, también se utilizó el método de k-indution , se usó un paso de 50 ya que es un valor óptimo de verificación al ser un proceso de pocas condiciones

En el archivo wrapper.sv se determinaron las reglas formales las cuales son las que se van a verificar el óptimo funcionamiento del proceso de generar una señal de PWM , estas 



VERIFICACION FORMAL
-------------------
1. 
```
if (init) begin
```
Valores de entrada.

```
          assume(reset);
```
El reset en 1 inicializa los valores de todas las variables del proceso.
       
```
          assume(io_duty<=255);
```
Como se utiliza un contador de 8 bit los valores de el ciclo útil no puede ser mayor
a este valor.

 ```
           assume(io_T<=255);
 ```
De igual forma al utilizar un contador de 8 bit obliga  a la variable del periodo “io_T”
a no superar el valor de 2 a la n_bits -1.
```
end
```
     
2. 
```
if (!reset) begin
```
Esta condición hace que todas las verificaciones del proceso se hagan cuando el reset es 0 ya que cuando se hace 1 y vuelve a las variables de salida a su valor inicial de 0.

- a. 
```
          if ($past(io_inc))begin
                    assert(!io_cont);
          end
```
En el primer ciclo de la variable “io_inc”, la salida “io_cont” que es el contador debe estar en cero.

- b. 
```
          if ($past(io_inc,2))begin
                    assert(io_cont);
          end
```
Después de dos ciclos anteriores de estar inicializado la variable “io_inc”, la salida “io_cont” que equivale al contador debe estar en 1.

- c. 
```
          if (io_cont<= io_duty)begin
                    assert(io_out);
                 end
```  
Siempre que la salida io_cont sea menor al ciclo Útil “io_duty”, la salida “io_out”  que es la señal PWM debe estar en 1.

- d. 
```
          if (io_cont> io_duty)begin
                    assert(!io_out);
          end
``` 
Cuando la salida del contador “io_cont” es mayor a la variable de entrada del ciclo útil io_duty, la salida “io_out” que equivale a las señal del PWM deberá estar en valor lógico de 0.

- e. 
```
          if (io_cont<=io_T)begin
                    assert($past(io_cont)+1==io_cont);
          end
``` 
En este paso se verifica si la señal del contador “io_cont” es menor a la señal de entrada del Periodo “io_T”, si es afirmativa el valor del contador se incrementará, verifica si el contador está contando.

- f. 
```
          assert(io_cont<=io_T);
```
Se verifica que la señal “io_cont” siempre sea igual o menor al periodo “io_T”, ya que el contador no puede ser mayor al periodo de la señal.

- g.  
```
          assert(io_duty<=io_T);
``` 
Se verifica que cuando se inicialice el proceso la variable del ciclo útil “io_duty” sea menor al periodo io_T ya que el ciclo útil es una variable que es mayor que cero y menor al periodo. 

 ```
 end
 ```
3.
```
if(!io_inc) assert(!io_out);
```
Verificación de que si la variable del enable es cero la salida del PWM está también en cero ya que no ha empezado la condición del reset no influye en la verificación pero se asume en 1.
