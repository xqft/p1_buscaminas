{ 
  LOS CAMBIOS REALIZADOS EN LA SEGUNDA ENTREGA ESTAN INDICADOS CON COMENTARIOS CON
  EL ASUNTO "CAMBIO 2DA ENTREGA".
}

{
Devuelve en t un Tablero para el cual todas sus Casillas:
  * Están ocultas
  * Están libres
  * No tienen minas alrededor
}
procedure IniciarTableroVacio (var t : Tablero);
var
  f : RangoFilas;
  c : RangoColum;
begin
  for f := 1 to CANT_FIL do
    for c := 1 to CANT_COL do
      with t[f, c] do
      begin
	oculto		:= true;
	tipo		:= Libre;
	minasAlrededor	:= 0
      end;
end;
{ CAMBIO 2DA ENTREGA: Nombres representativos para las variables f, c. }


{
Para toda Casilla c del Tablero que es una Mina, c deja de estar oculta
}
procedure DesocultarMinas (var t : Tablero);
var
  f : RangoFilas;
  c : RangoColum;
begin
  for f := 1 to CANT_FIL do
    for c := 1 to CANT_COL do
      if t[f, c].tipo = Mina then t[f, c].oculto := false
end;
{ CAMBIO 2DA ENTREGA: Nombres representativos para las variables f, c. }


{
Devuelve true si tanto la fila f como la columna c son válidas,
es decir corresponden a una casilla del tablero.
De lo contrario devuelve false.
}
function EsPosicionValida (f, c : integer) : boolean;
begin
  EsPosicionValida := (1 <= f) and (f <= CANT_FIL) and
		      (1 <= c) and (c <= CANT_COL)
end;
{ CAMBIO 2DA ENTREGA: Reordenamiento para mejor legibilidad. }


{
Agrega minas al Tablero t en cada una de las casillas c correspondientes a
posiciones contenidas en m, es decir que dichas casillas cambien su tipo a Mina.

Adicionalmente asigna el valor del campo minasAlrededor de las casillas del tablero
que queden libres. Este deberá contener la cantidad de casillas adyacentes que 
son minas.
}
procedure AgregarMinas (m : Minas; var t : Tablero);
var
  i : 1..MAX_MIN;
  f : RangoFilas;
  c : RangoColum;
  df, dc : -1..1;
begin
  for i := 1 to m.tope do
  begin
    f := m.elems[i].fila;
    c := m.elems[i].columna;
    t[f, c].tipo := Mina;

    for df := -1 to 1 do
      for dc := -1 to 1 do
	if EsPosicionValida(f + df, c + dc) then
	  with t[f + df, c + dc] do
	    if (tipo = Libre) then
	      minasAlrededor := minasAlrededor + 1
  end;
end;


{
Si la fila f y columna c corresponden a una Casilla cas válida del Tablero t 
(ver procedimiento EsPosicionValida) y cas es Libre entonces cas deja de estar 
oculta.
Adicionalmente si la Casilla cumple con lo anterior y no tiene minas alrededor 
entonces se agrega la Posicion correspondiente a dicha casilla al final de la 
listaPos libres.
}
procedure Desocultar (f, c : integer; var t : Tablero; var libres : ListaPos);
var
  pos : Posicion;
begin
  with t[f, c] do
    if EsPosicionValida(f, c) and oculto and (tipo = Libre) then
    begin
      oculto := false;
      if minasAlrededor = 0 then
      begin
	pos.fila    := f;
	pos.columna := c;
	AgregarAlFinal(pos, libres)
      end;
    end;
end;


{
Desoculta (ver procedimiento Desocultar) todas las casillas adyacentes a la
Casilla del Tablero t asociada a la fila f y la columna c.
}
procedure DesocultarAdyacentes (f, c : integer; var t : Tablero;
                                var libres : ListaPos);
var
  df, dc : -1..1;
begin
  for df := -1 to 1 do
    for dc := -1 to 1 do
      if not ( (df = 0) and (dc = 0) ) and EsPosicionValida(f + df, c + dc) then
	Desocultar(f + df, c + dc, t, libres)
end;


{
Desoculta (ver procedimiento Desocultar) la Casilla del Tablero t asociada a la 
fila f y la columna c. Si esa casilla está libre y no tiene minas alrededor, 
también se desocultan todas sus casillas adyacentes. Para las casillas adyacentes 
desocultadas se repite el mismo procedimiento de desocultar a sus adyacentes si 
no tienen minas alrededor, y así sucesivamente hasta que no queden más casillas 
adyacentes que cumplan con estas condiciones.
}
procedure DesocultarDesde (f : RangoFilas;  c : RangoColum; var t : Tablero);
var
  l   : ListaPos;
  pos : Posicion;
begin
  l := nil;
  Desocultar(f, c, t, l);

  while l <> nil do
  begin
    PrimeraPosicion(pos, l);
    DesocultarAdyacentes(pos.fila, pos.columna, t, l)
  end;
end;


{
Devuelve true si no existe ninguna Casilla en el Tablero t que cumpla con estar 
oculta y ser Libre. En otro caso devuelve false.
}
function EsTableroCompleto(t : Tablero) : boolean;
var
  f : RangoFilas;
  c : RangoColum;
begin
  EsTableroCompleto := true;

  for f := 1 to CANT_FIL do
    for c := 1 to CANT_COL do
      if t[f, c].oculto and (t[f, c].tipo = Libre) then
	EsTableroCompleto := false
end;
{
  CAMBIO 2DA ENTREGA: filas y col. estaban dados vuelta, lo cual provocaba range check error
  (201) al intentar acceder a la columna 11 de la matriz tablero, que no existe. De haber
  sido consistente con los nombres para f y c quizá me habría dado cuenta antes del error.
}

{
  En toda la tarea prioricé la legibilidad y simpleza del código frente a la eficiencia
  de los algoritmos, por ejemplo hay bucles que se ejecutan para cada casilla pero
  pueden terminar antes, para esto se necesita reemplazar bucles for por while/repeat que
  ensucian mucho el código. Las mejoras de rendimiento no son apreciables en este caso.
}
