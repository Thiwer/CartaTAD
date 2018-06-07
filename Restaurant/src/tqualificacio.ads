generic

   type calificacion is private;

package tqualificacio is

   type qualificacio is limited private;
   mal_uso: exception;
   espacio_desbordado: exception;
   procedure cvacia (qu: out qualificacio);
   procedure poner (qu: in out qualificacio; x: in elem);
   procedure borrar_primero(qu: in out qualificacio);
   function coger_primero (qu: in qualificacio) return elem;
   function esta_vacia(qu: in qualificacio) return boolean;
private

   type indice is new integer range 1..tamaño;
   type espacio_memoria is array(indice) of elem;
   type cola is record
      a: espacio_memoria;
      p, q: indice; --q inicio cola, p final cola
      n: natural; --número de elementos en la cola
   end record;

end tqualificacio;
